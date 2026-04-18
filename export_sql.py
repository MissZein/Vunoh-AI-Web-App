import sqlite3
import os

# Path to your database
db_path = 'db.sqlite3'
dump_path = 'vunoh_db_dump.sql'

if os.path.exists(db_path):
    with sqlite3.connect(db_path) as conn:
        with open(dump_path, 'w', encoding='utf-8') as f:
            for line in conn.iterdump():
                f.write('%s\n' % line)
    print(f"✅ Success! Your SQL dump is ready at: {dump_path}")
else:
    print("❌ Error: db.sqlite3 not found in this folder.")