CREATE TABLE budget_users (
    id BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

COMMENT ON COLUMN budget_users.id IS 'Identyfikator użytkownika konta';
COMMENT ON COLUMN budget_users.first_name IS 'Imię użytkownika konta';
COMMENT ON COLUMN budget_users.first_name IS 'Nazwisko użytwkownika konta';


CREATE TABLE accounts (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    type VARCHAR(10) NOT NULL
);

COMMENT ON COLUMN accounts.id IS 'Identyfikator konta';
COMMENT ON COLUMN accounts.name IS 'Nazwa konta';

CREATE TABLE budget_user_to_account (
    id BIGSERIAL PRIMARY KEY,
    user_account_id BIGINT NOT NULL,
    account_id BIGINT NOT NULL,
    CONSTRAINT fk_user_account
        FOREIGN KEY (user_account_id)
        REFERENCES budget_users(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_account
        FOREIGN KEY (account_id)
        REFERENCES accounts(id)
        ON DELETE CASCADE
);

COMMENT ON COLUMN budget_user_to_account.id IS 'Identyfikator relacji';
COMMENT ON COLUMN budget_user_to_account.user_account_id IS 'Identyfikator użytkownika konta';
COMMENT ON COLUMN budget_user_to_account.account_id IS 'Identyfikator konta';


CREATE TABLE categories (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    account_id BIGINT NOT NULL,
    CONSTRAINT fk_account
        FOREIGN KEY (account_id)
        REFERENCES accounts(id)
        ON DELETE SET NULL
);

COMMENT ON COLUMN categories.id IS 'Identyfikator kategorii';
COMMENT ON COLUMN categories.account_id IS 'Identyfikator konta';


CREATE TABLE expenses (
    id BIGSERIAL PRIMARY KEY,
    value DECIMAL NOT NULL,
    category_id BIGINT NOT NULL,
    creation_date_time TIMESTAMP NOT NULL,
    account_id BIGINT NOT NULL,
    change_time TIMESTAMP,
    change_account_user_id BIGINT,
    delete_time TIMESTAMP,
    CONSTRAINT fk_category
        FOREIGN KEY (category_id)
        REFERENCES categories(id)
        ON DELETE SET NULL,
    CONSTRAINT fk_account_id
        FOREIGN KEY (account_id)
        REFERENCES accounts(id)
        ON DELETE SET NULL,
    CONSTRAINT fk_change_account_user
            FOREIGN KEY (change_account_user_id)
            REFERENCES budget_users(id)
            ON DELETE SET NULL
);

COMMENT ON COLUMN expenses.id IS 'Identyfikator wydatku';
COMMENT ON COLUMN expenses.value IS 'Wartość wydatku';
COMMENT ON COLUMN expenses.category_id IS 'ID kategorii wydatku';
COMMENT ON COLUMN expenses.creation_date_time IS 'Data i godzina utworzenia wydatku';
COMMENT ON COLUMN expenses.account_id IS 'ID użytkownika powiązanego z kontem';
COMMENT ON COLUMN expenses.change_time IS 'Data i godzina zmiany';
COMMENT ON COLUMN expenses.change_account_user_id IS 'ID użytkownika, który zmienił rekord';
COMMENT ON COLUMN expenses.delete_time IS 'Data i godzina usunięcia';


CREATE TABLE incomes (
    id BIGSERIAL PRIMARY KEY,
    value DECIMAL NOT NULL,
    category_id BIGINT NOT NULL,
    creation_date_time TIMESTAMP NOT NULL,
    account_id BIGINT NOT NULL,
    change_time TIMESTAMP,
    change_account_user_id BIGINT,
    delete_time TIMESTAMP,
    CONSTRAINT fk_category
        FOREIGN KEY (category_id)
        REFERENCES categories(id)
        ON DELETE SET NULL,
    CONSTRAINT fk_account_id
            FOREIGN KEY (account_id)
            REFERENCES accounts(id)
            ON DELETE SET NULL,
    CONSTRAINT fk_change_account_user
            FOREIGN KEY (change_account_user_id)
            REFERENCES budget_users(id)
            ON DELETE SET NULL
);

COMMENT ON COLUMN incomes.id IS 'Identyfikator wpływu';
COMMENT ON COLUMN incomes.value IS 'Wartość wpływu';
COMMENT ON COLUMN incomes.category_id IS 'ID kategorii wpływu';
COMMENT ON COLUMN incomes.creation_date_time IS 'Data i godzina utworzenia wpływu';
COMMENT ON COLUMN incomes.account_id IS 'ID użytkownika powiązanego z kontem';
COMMENT ON COLUMN incomes.change_time IS 'Data i godzina zmiany';
COMMENT ON COLUMN incomes.change_account_user_id IS 'ID użytkownika, który zmienił rekord';
COMMENT ON COLUMN incomes.delete_time IS 'Data i godzina usunięcia';



GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO my_budget_user;

