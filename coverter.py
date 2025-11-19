#!/usr/bin/env python3
"""
SQL Server to MySQL Conversion Script
Converts SQL Server T-SQL syntax to MySQL syntax
"""

import re
import sys


def convert_to_mysql(input_file, output_file):
    """Convert SQL Server script to MySQL syntax"""

    print(f"Reading {input_file}...")

    with open(input_file, "r", encoding="utf-8") as f:
        content = f.read()

    print("Converting SQL Server syntax to MySQL...")

    # Remove SQL Server specific commands
    content = re.sub(r"USE \[.*?\]\s*GO\s*", "", content, flags=re.IGNORECASE)
    content = re.sub(
        r"SET ANSI_NULLS (ON|OFF)\s*GO\s*", "", content, flags=re.IGNORECASE
    )
    content = re.sub(
        r"SET QUOTED_IDENTIFIER (ON|OFF)\s*GO\s*", "", content, flags=re.IGNORECASE
    )
    content = re.sub(
        r"SET ANSI_PADDING (ON|OFF)\s*GO\s*", "", content, flags=re.IGNORECASE
    )
    content = re.sub(
        r"SET ARITHABORT (ON|OFF)\s*GO\s*", "", content, flags=re.IGNORECASE
    )

    # Remove stored procedures (before removing GO statements)
    content = re.sub(
        r"CREATE\s+PROC(?:EDURE)?\s+[^\s]+.*?(?=CREATE\s+(?:TABLE|PROC|FUNCTION|VIEW|INDEX)|ALTER\s+TABLE|$)",
        "-- Stored procedure removed (manual conversion required)\n\n",
        content,
        flags=re.DOTALL | re.IGNORECASE,
    )

    # Remove USER DEFINED FUNCTIONS (before removing GO statements)
    content = re.sub(
        r"CREATE\s+FUNCTION\s+[^\s]+.*?(?=CREATE\s+(?:TABLE|PROC|FUNCTION|VIEW|INDEX)|ALTER\s+TABLE|$)",
        "-- User defined function removed (manual conversion required)\n\n",
        content,
        flags=re.DOTALL | re.IGNORECASE,
    )

    # Remove GO statements
    content = re.sub(r"\bGO\b\s*", ";\n", content, flags=re.IGNORECASE)

    # Remove SQL Server comments like /****** Object: ******/
    content = re.sub(r"/\*+\s*Object:.*?\*+/", "", content, flags=re.DOTALL)

    # Remove dbo schema prefix BEFORE converting brackets
    content = re.sub(r"\[dbo\]\.", "", content)

    # Convert data types BEFORE converting brackets (important!)
    # uniqueidentifier -> CHAR(36) (for UUID storage)
    content = re.sub(
        r"\[uniqueidentifier\]", "[CHAR_36_UUID]", content, flags=re.IGNORECASE
    )

    # Convert square brackets [table] to backticks `table`
    content = re.sub(r"\[([^\]]+)\]", r"`\1`", content)

    # Now convert the placeholder back to CHAR(36)
    content = re.sub(r"`CHAR_36_UUID`", "CHAR(36)", content, flags=re.IGNORECASE)

    # Convert IDENTITY to AUTO_INCREMENT
    content = re.sub(
        r"IDENTITY\s*\(\s*(\d+)\s*,\s*(\d+)\s*\)",
        r"AUTO_INCREMENT",
        content,
        flags=re.IGNORECASE,
    )

    # Convert data types - MUST do nvarchar(max) before nvarchar
    # nvarchar(max) -> TEXT
    content = re.sub(
        r"\bnvarchar\s*\(\s*max\s*\)", "TEXT", content, flags=re.IGNORECASE
    )

    # varchar(max) -> TEXT
    content = re.sub(r"\bvarchar\s*\(\s*max\s*\)", "TEXT", content, flags=re.IGNORECASE)

    # nvarchar -> VARCHAR (MySQL uses utf8mb4 by default)
    content = re.sub(r"\bnvarchar\b", "VARCHAR", content, flags=re.IGNORECASE)

    # datetime -> DATETIME
    content = re.sub(r"\bdatetime\b", "DATETIME", content, flags=re.IGNORECASE)

    # bit -> TINYINT(1)
    content = re.sub(r"\bbit\b", "TINYINT(1)", content, flags=re.IGNORECASE)

    # bigint -> BIGINT
    content = re.sub(r"\bbigint\b", "BIGINT", content, flags=re.IGNORECASE)

    # int -> INT
    content = re.sub(r"\bint\b", "INT", content, flags=re.IGNORECASE)

    # smallint -> SMALLINT
    content = re.sub(r"\bsmallint\b", "SMALLINT", content, flags=re.IGNORECASE)

    # ntext -> TEXT
    content = re.sub(r"\bntext\b", "TEXT", content, flags=re.IGNORECASE)

    # Convert PRIMARY KEY CLUSTERED to PRIMARY KEY
    content = re.sub(
        r"PRIMARY\s+KEY\s+CLUSTERED", "PRIMARY KEY", content, flags=re.IGNORECASE
    )
    content = re.sub(
        r"PRIMARY\s+KEY\s+NONCLUSTERED", "PRIMARY KEY", content, flags=re.IGNORECASE
    )

    # Convert NONCLUSTERED INDEX to INDEX
    content = re.sub(r"NONCLUSTERED\s+INDEX", "INDEX", content, flags=re.IGNORECASE)
    content = re.sub(r"CLUSTERED\s+INDEX", "INDEX", content, flags=re.IGNORECASE)

    # Convert WITH (PAD_INDEX = ...) to empty (MySQL doesn't support this)
    content = re.sub(
        r"WITH\s*\([^)]*PAD_INDEX[^)]*\)", "", content, flags=re.IGNORECASE
    )

    # Remove TEXTIMAGE_ON [PRIMARY]
    content = re.sub(r"TEXTIMAGE_ON\s+`[^`]+`", "", content, flags=re.IGNORECASE)

    # Convert ON [PRIMARY] to empty (MySQL doesn't need filegroup specification)
    content = re.sub(r"ON\s+`PRIMARY`", "", content, flags=re.IGNORECASE)

    # Remove CONSTRAINT names for default values (MySQL handles differently)
    # But keep the constraint name for primary keys and foreign keys

    # Convert ALTER TABLE ... ADD DEFAULT to ALTER TABLE ... ALTER COLUMN ... SET DEFAULT
    content = re.sub(
        r"ALTER\s+TABLE\s+(`[^`]+`)\s+ADD\s+CONSTRAINT\s+`[^`]+`\s+DEFAULT\s+\(([^)]+)\)\s+FOR\s+(`[^`]+`)",
        r"ALTER TABLE \1 ALTER COLUMN \3 SET DEFAULT \2",
        content,
        flags=re.IGNORECASE,
    )

    # Remove EXEC statements (MySQL doesn't use EXEC)
    content = re.sub(r"\bEXEC\s+", "", content, flags=re.IGNORECASE)

    # Convert functions - SQL Server to MySQL
    content = re.sub(r"\bGETDATE\s*\(\s*\)", "NOW()", content, flags=re.IGNORECASE)
    content = re.sub(
        r"\bGETUTCDATE\s*\(\s*\)", "UTC_TIMESTAMP()", content, flags=re.IGNORECASE
    )
    content = re.sub(r"\bNEWID\s*\(\s*\)", "UUID()", content, flags=re.IGNORECASE)

    # Convert ALTER COLUMN to MODIFY COLUMN
    content = re.sub(r"ALTER\s+COLUMN", "MODIFY COLUMN", content, flags=re.IGNORECASE)

    # Fix column definition syntax
    # Pattern: `ColumnName` `DataType` -> `ColumnName` DataType
    # Remove backticks from data types (including CHAR with size)
    type_pattern = r"`\s*(BIGINT|INT|SMALLINT|TINYINT|DATETIME|VARCHAR|TEXT|DECIMAL|CHAR|FLOAT|DOUBLE|REAL|NUMERIC|BIT|DATE|TIME|TIMESTAMP|BLOB|LONGTEXT|MEDIUMTEXT)\s*`"
    content = re.sub(type_pattern, r"\1", content, flags=re.IGNORECASE)

    # Fix `CHAR(36)` -> CHAR(36)
    content = re.sub(
        r"`CHAR\s*\(\s*(\d+)\s*\)`", r"CHAR(\1)", content, flags=re.IGNORECASE
    )

    # Fix patterns like `TINYINT(1) to TINYINT(1)
    content = re.sub(
        r"`\s*TINYINT\s*\(\s*1\s*\)", "TINYINT(1)", content, flags=re.IGNORECASE
    )

    # Fix patterns like TINYINT(1)` to TINYINT(1) (trailing backtick)
    content = re.sub(
        r"TINYINT\s*\(\s*1\s*\)\s*`", "TINYINT(1)", content, flags=re.IGNORECASE
    )

    # Fix patterns like `varchar`(20) to varchar(20)
    content = re.sub(
        r"`\s*(varchar|char|decimal)\s*`\s*\(", r"\1(", content, flags=re.IGNORECASE
    )

    # Fix CONSTRAINT name` to CONSTRAINT name
    content = re.sub(r"(CONSTRAINT\s+\w+)\s*`", r"\1", content, flags=re.IGNORECASE)

    # Fix VARCHAR(max) to TEXT (do this after removing backticks)
    content = re.sub(r"VARCHAR\s*\(\s*max\s*\)", "TEXT", content, flags=re.IGNORECASE)

    # Fix CONSTRAINT `name to CONSTRAINT name (remove leading backtick)
    content = re.sub(
        r"CONSTRAINT\s+`([^`]+)`", r"CONSTRAINT \1", content, flags=re.IGNORECASE
    )

    # Fix datetime2(7) to DATETIME(6) - MySQL max precision is 6
    content = re.sub(
        r"datetime2\s*\(\s*7\s*\)", "DATETIME(6)", content, flags=re.IGNORECASE
    )

    # Fix time(7) to TIME(6) - MySQL max precision is 6
    content = re.sub(r"time\s*\(\s*7\s*\)", "TIME(6)", content, flags=re.IGNORECASE)

    # Convert datetime2 to DATETIME
    content = re.sub(r"\bdatetime2\b", "DATETIME", content, flags=re.IGNORECASE)

    # Handle ASC/DESC in indexes (MySQL syntax is slightly different)
    # This is generally compatible, so we leave it as is

    # Add MySQL header
    mysql_header = """-- MySQL Database Script
-- Converted from SQL Server
-- Generated: 2025-10-16
-- Character Set: utf8mb4
-- Collation: utf8mb4_unicode_ci

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

"""

    # Add MySQL footer
    mysql_footer = """
SET FOREIGN_KEY_CHECKS = 1;
"""

    content = mysql_header + content + mysql_footer

    # Clean up multiple semicolons
    content = re.sub(r";+", ";", content)

    # Clean up multiple newlines
    content = re.sub(r"\n{3,}", "\n\n", content)

    print(f"Writing to {output_file}...")

    with open(output_file, "w", encoding="utf-8") as f:
        f.write(content)

    print(f"Conversion complete! Output written to {output_file}")
    print(
        "\nNote: Please review the generated SQL file as some complex constructs may need manual adjustment:"
    )
    print("- User defined functions have been removed (requires manual conversion)")
    print("- Stored procedures may need manual review")
    print("- Complex constraints may need adjustment")
    print("- Data types have been converted to MySQL equivalents")


if __name__ == "__main__":
    input_file = r"d:\Source\moducoding-web-aidt-mysql\ModuCoding.API.AIDT\current.sql"
    output_file = r"d:\Source\moducoding-web-aidt-mysql\ModuCoding.API.AIDT\newsql.sql"

    convert_to_mysql(input_file, output_file)
