
1. Create database `my_budget_db`:
    ```
    CREATE DATABASE my_budget_db;
    ```
2. Create user:
    ```
     CREATE USER my_budget_user WITH ENCRYPTED PASSWORD '<your_password>';
    ```
3. Create `liquiase.properties` file under src/main/resources and fill relevant values:

    ```driver= org.postgresql.Driver
    url= jdbc:postgresql://<host>:5432/my_budget_db
    username=<user-name>
    password=<password>
    changeLogFile= db/changelog-master.xml
    ```

4. Update database using liquibase:

    ```
    liquibase:update
    ```
   Note: User in mvn-liquibase command is not the same user as my_budget_user.
         You should have user for maintain database different from my_budget_user.