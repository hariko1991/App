#!/bin/sh
set -e

# 修复 schema.sql 缺失问题
if [ ! -f /app/src/database/schema.sql ] && [ -f /app/src/database/schema-optimized.sql ]; then
  echo "Creating symlink: schema-optimized.sql -> schema.sql"
  ln -sf /app/src/database/schema-optimized.sql /app/src/database/schema.sql
fi

# 执行原始的 entrypoint
exec /usr/local/bin/docker-entrypoint.sh "$@"
