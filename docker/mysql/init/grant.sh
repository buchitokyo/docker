(
mysql -uroot -p$DB_ROOT_PASS <<EOF
    GRANT ALL ON *.* TO '$DB_USER'@'%';
EOF
)