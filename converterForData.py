#!/usr/bin/env python3
"""
SQL Server to MySQL Data Conversion Script
Converts SQL Server INSERT statements to MySQL syntax
"""

import re
import sys
from pathlib import Path


def convert_data_to_mysql(input_file, output_file):
    """SQL Server INSERT 문을 MySQL 구문으로 변환"""

    with open(input_file, "r", encoding="utf-8") as f:
        content = f.read()

    # 2025-11-25, 김병현 수정: SQL Server 데이터 삽입 관련 명령어 제거
    # USE 데이터베이스 구문 제거
    content = re.sub(r"USE \[.*?\]\s*GO\s*", "", content, flags=re.IGNORECASE)

    # SET ANSI 관련 설정 제거
    content = re.sub(
        r"SET ANSI_NULLS (ON|OFF)\s*GO\s*", "", content, flags=re.IGNORECASE
    )
    content = re.sub(
        r"SET QUOTED_IDENTIFIER (ON|OFF)\s*GO\s*", "", content, flags=re.IGNORECASE
    )
    content = re.sub(
        r"SET ANSI_PADDING (ON|OFF)\s*GO\s*", "", content, flags=re.IGNORECASE
    )

    # 2025-11-25, 김병현 수정: SET IDENTITY_INSERT 구문 제거 (MySQL에서 불필요)
    # 대괄호 형식의 테이블명을 포함하여 제거 (GO 구문 변환 전에 먼저 제거)
    # [dbo].[TableName] 형식을 처리
    content = re.sub(
        r"SET IDENTITY_INSERT\s+\[[\w]+\]\.\[[\w]+\]\s+(ON|OFF)\s*\n?\s*GO\s*",
        "",
        content,
        flags=re.IGNORECASE,
    )

    # 2025-11-25, 김병현 수정: GO 구문을 세미콜론으로 변환
    content = re.sub(r"\bGO\b\s*", ";\n", content, flags=re.IGNORECASE)

    # 2025-11-25, 김병현 수정: dbo 스키마 제거 (대괄호 포함)
    content = re.sub(r"\[dbo\]\.", "", content)

    # 2025-11-28, 김병현 수정: 대괄호를 백틱으로 변환 [table] -> `table`
    # 문자열 리터럴 내부의 대괄호는 변환하지 않도록 전체 content를 한 번에 처리
    def replace_brackets_outside_strings(text):
        """문자열 리터럴 외부의 대괄호만 백틱으로 변환"""
        result = []
        in_string = False
        i = 0

        while i < len(text):
            # N' 또는 ' 로 문자열 시작 확인
            if not in_string:
                if i + 1 < len(text) and text[i : i + 2] in ["N'", "n'"]:
                    result.append(text[i : i + 2])
                    in_string = True
                    i += 2
                    continue
                elif text[i] == "'":
                    result.append(text[i])
                    in_string = True
                    i += 1
                    continue

            # 문자열 내부에서 종료 확인
            if in_string and text[i] == "'":
                result.append(text[i])
                # 다음 문자가 '인지 확인 (이스케이프)
                if i + 1 < len(text) and text[i + 1] == "'":
                    result.append("'")
                    i += 2
                    continue
                else:
                    in_string = False
                    i += 1
                    continue

            # 대괄호 처리 (문자열 외부에서만 변환)
            if not in_string and text[i] == "[":
                end = text.find("]", i)
                if end != -1:
                    result.append("`")
                    result.append(text[i + 1 : end])
                    result.append("`")
                    i = end + 1
                    continue

            result.append(text[i])
            i += 1

        return "".join(result)

    # 전체 content를 한 번에 처리
    content = replace_brackets_outside_strings(content)

    # 2025-11-25, 김병현 수정: SQL Server의 0x (hex 리터럴) 처리
    # N'...' 변환 전에 먼저 처리하여 문자열 내부의 0x는 변환하지 않음
    # 0x1234 -> UNHEX('1234'), VALUES 절에서 단독으로 사용되는 경우만 변환
    # 패턴: 콤마, 괄호, 공백 다음에 오는 0x만 변환
    # (0x...) 또는 , 0x... 또는 공백 0x... 패턴만 변환
    content = re.sub(r"([\(,\s])0x([0-9A-Fa-f]+)\b", r"\1UNHEX('\2')", content)

    # 2025-11-25, 김병현 수정: N'문자열' 유니코드 리터럴을 일반 문자열로 변환
    # N'...' -> '...'
    # 주의: \n' 같은 이스케이프 시퀀스는 변환하지 않도록 앞에 문자나 백슬래시가 없는 경우만 변환
    content = re.sub(r"(?<![\\a-zA-Z0-9_])N'", "'", content, flags=re.IGNORECASE)

    # 2025-11-25, 김병현 수정: SQL Server 함수를 MySQL 함수로 변환
    # GETDATE() -> NOW()
    content = re.sub(r"\bGETDATE\s*\(\s*\)", "NOW()", content, flags=re.IGNORECASE)

    # GETUTCDATE() -> UTC_TIMESTAMP()
    content = re.sub(
        r"\bGETUTCDATE\s*\(\s*\)", "UTC_TIMESTAMP()", content, flags=re.IGNORECASE
    )

    # NEWID() -> UUID()
    content = re.sub(r"\bNEWID\s*\(\s*\)", "UUID()", content, flags=re.IGNORECASE)

    # 2025-11-25, 김병현 수정: CAST 함수 변환
    # CAST(0 AS BIT) -> CAST(0 AS UNSIGNED) 또는 단순히 0으로 변환
    content = re.sub(
        r"CAST\s*\(\s*([01])\s+AS\s+BIT\s*\)",
        r"\1",
        content,
        flags=re.IGNORECASE,
    )

    # 2025-11-25, 김병현 수정: DateTime2를 DATETIME으로 변환
    content = re.sub(
        r"\bDateTime2\b",
        "DATETIME",
        content,
        flags=re.IGNORECASE,
    )

    # 2025-11-25, 김병현 수정: INSERT 문에 INTO 키워드 추가
    # INSERT table -> INSERT INTO table
    content = re.sub(
        r"\bINSERT\s+(`[\w]+`)",
        r"INSERT INTO \1",
        content,
        flags=re.IGNORECASE,
    )

    # 2025-11-25, 김병현 수정: MySQL 헤더 추가
    mysql_header = """-- MySQL Data Insert Script
-- Converted from SQL Server
-- Generated: 2025-11-25
-- Character Set: utf8mb4
-- Collation: utf8mb4_unicode_ci

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';

"""

    # 2025-11-25, 김병현 수정: MySQL 푸터 추가
    mysql_footer = """
SET FOREIGN_KEY_CHECKS = 1;
"""

    content = mysql_header + content + mysql_footer

    # 2025-11-25, 김병현 수정: 중복 세미콜론 정리
    content = re.sub(r";+", ";", content)

    # 2025-11-25, 김병현 수정: INSERT VALUES 절 내부의 작은따옴표 이스케이프 처리
    # 모든 변환이 끝난 후 마지막에 처리하여 UNHEX 등의 변환으로 생성된 작은따옴표는 이스케이프하지 않음
    def escape_quotes_in_values(text):
        """VALUES 절 내부의 문자열 리터럴 작은따옴표를 이스케이프"""
        in_string = False
        result = []
        i = 0

        while i < len(text):
            char = text[i]

            if char == "'":
                if not in_string:
                    # 문자열 시작
                    in_string = True
                    result.append("'")
                    string_content = []
                    i += 1

                    # 문자열 끝까지 읽기
                    while i < len(text):
                        if text[i] == "'":
                            # 다음 문자도 '인지 확인 (이미 이스케이프된 경우)
                            if i + 1 < len(text) and text[i + 1] == "'":
                                # 이미 이스케이프된 '' - 그대로 유지
                                string_content.append("''")
                                i += 2
                                continue
                            else:
                                # 문자열 끝 - 내부의 단일 '를 ''로 변경
                                content_str = "".join(string_content)
                                escaped = content_str.replace("'", "''")
                                result.append(escaped)
                                result.append("'")
                                in_string = False
                                break
                        else:
                            string_content.append(text[i])
                        i += 1
                else:
                    result.append(char)
            else:
                result.append(char)

            i += 1

        return "".join(result)

    # 전체 내용에서 작은따옴표 이스케이프 처리
    content = escape_quotes_in_values(content)

    # 2025-11-25, 김병현 수정: 중복 이스케이프된 작은따옴표 정리
    # '''' (네 개) -> '' (두 개)로 변경하여 과도한 이스케이프 제거
    content = content.replace("''''", "''")

    with open(output_file, "w", encoding="utf-8") as f:
        f.write(content)


if __name__ == "__main__":
    # 2025-11-25, 김병현 수정: target_data 폴더의 모든 SQL 파일을 output_data 폴더로 변환
    target_dir = Path("target_data")
    output_dir = Path("output_data")

    # output_data 폴더가 없으면 생성
    output_dir.mkdir(exist_ok=True)

    # target_data 폴더가 없으면 생성하고 안내 메시지 출력
    if not target_dir.exists():
        target_dir.mkdir(exist_ok=True)
        print(f"'{target_dir}' 폴더가 생성되었습니다.")
        print(f"변환할 SQL Server INSERT 스크립트를 '{target_dir}' 폴더에 넣어주세요.")
        sys.exit(0)

    # target_data 폴더의 모든 .sql 파일 찾기
    sql_files = list(target_dir.glob("*.sql"))

    if not sql_files:
        print(f"'{target_dir}' 폴더에 SQL 파일이 없습니다.")
        print(f"변환할 SQL Server INSERT 스크립트를 '{target_dir}' 폴더에 넣어주세요.")
        sys.exit(0)

    print(f"총 {len(sql_files)}개의 SQL 파일을 변환합니다.\n")

    # 각 SQL 파일을 변환
    for i, sql_file in enumerate(sql_files, 1):
        output_file = output_dir / sql_file.name
        print(f"[{i}/{len(sql_files)}] {sql_file.name}")
        convert_data_to_mysql(str(sql_file), str(output_file))

    print(f"\n✓ 완료: {len(sql_files)}개 파일 변환됨 → {output_dir}/")
