
# 수작업 내역
1. Interview2QuestionCommentary 키 위치 변경 
2. link_temp primary key 값 넣도록 변경
3. default 값 세팅 관련 스크립트 제거
    - MYSQL 에 default 값 세팅 관련 필요 없는듯

# Claude 작업내역 

## 수정된 내용 (2025-11-26, 김병현 수정)

1. **556번 줄** - `Time` 컬럼에 백틱 추가
2. **676번 줄** - `sysname` 타입을 `VARCHAR(128)`로 변경
3. **680번 줄** - `varbinary(max)`를 `LONGBLOB`로 변경
4. **282, 311번 줄** - 잘못된 CAST 문법을 단순 숫자 `0`으로 변경
5. **708-710번 줄** - `Interview2QuestionExampleCode` 테이블의 DEFAULT 제약조건 문법 수정
6. **716번 줄** - `Interview2QuestionLink` 테이블의 `CreatedAt` DEFAULT 제약조건 문법 수정
7. **726번 줄** - `Interview2TestEvaluationCodingResult` 테이블의 `Time` 컬럼 DEFAULT 제약조건 문법 수정
8. **736-738번 줄** - `Member` 테이블의 `CreateDate`, `ModifyDate` DEFAULT 제약조건 문법 수정
9. **742번 줄** - `Member` 테이블의 `Token` DEFAULT 제약조건 문법 수정
10. **766-768번 줄** - `QuestionFolder` 테이블의 `CreatedAt`, `UpdatedAt` DEFAULT 제약조건 문법 수정
11. **776-778번 줄** - `QuestionGroup` 테이블의 `CreatedAt`, `UpdatedAt` DEFAULT 제약조건 문법 수정