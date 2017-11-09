About populate script
=================

This is the script we used to generate our stock table. The script uses `Python3`.

If you want to use this script, you will first need to install Pony for python3:
```bash
pip install pony
```
And then install the database drivers.  
We uses `MySQL` and `PostgreSQL`, so we install the drivers for them:
```bash
pip install pymysql
pip install psycopg2
```
[More references](https://docs.ponyorm.com/api_reference.html#api-reference)

After that, you just need to open the script and set the database configurations.  
And run the script:
```bash
python populate.py
```

It will take quite a while to insert 10 millions records into the table.