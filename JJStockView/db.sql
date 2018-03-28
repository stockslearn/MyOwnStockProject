-- 创建个人表 --
CREATE TABLE IF NOT EXISTS T_Person (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    age INTEGER
);
-- 创建学生表 --
CREATE TABLE IF NOT EXISTS T_Student (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    age INTEGER,
    score INTEGER
);

create table if not exists T_Stock (
    id integer not null primary key autoincrement,
    bond_id text,
    bond_nm text,
    convert_price text,
    convert_value text,
    issue_dt text,
    full_price text,
    maturity_dt text,
    put_convert_price text,
    ration_cd text,
    stock_id text,
    stock_net_value text,
    stock_nm text,
    year_left text,
    ytm_rt text,
    ytm_rt_tax text,
    volume text
);
