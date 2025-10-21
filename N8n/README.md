# n8n 部署配置

## 部署说明

此配置用于部署 n8n 工作流自动化平台，支持生产环境使用。

### 前置条件

- 已部署 PostgreSQL 数据库
- 已部署 Redis 服务
- Docker 和 Docker Compose

### 配置步骤

1. **复制环境变量文件**
   ```bash
   cp .env.example .env
   ```

2. **编辑环境变量**
   编辑 `.env` 文件，配置以下必要参数：
   
   - `POSTGRES_PASSWORD`: PostgreSQL 密码
   - `N8N_ENCRYPTION_KEY`: n8n 加密密钥（至少32字符）
   - `N8N_BASIC_AUTH_PASSWORD`: 管理员密码
   - `WEBHOOK_URL`: Webhook URL
   - `N8N_HOST`: 域名

3. **如果使用外部数据库服务**
   在 `.env` 文件中取消注释并配置：
   ```
   DB_POSTGRESDB_HOST=your_postgres_host
   QUEUE_BULL_REDIS_HOST=your_redis_host
   ```

4. **SSL 证书配置**
   如果使用 Nginx 反向代理，请将 SSL 证书放置在 `ssl/` 目录：
   ```
   ssl/cert.pem
   ssl/key.pem
   ```

5. **启动服务**
   ```bash
   # 启动所有服务
   docker-compose up -d
   
   # 仅启动 n8n（如果不需要 nginx）
   docker-compose up -d n8n
   
   # 查看日志
   docker-compose logs -f n8n
   ```

### 服务说明

- **n8n**: 主服务，端口 5678
- **n8n-worker**: 队列工作进程（可选，用于高负载场景）
- **nginx**: 反向代理（可选，提供 HTTPS 和负载均衡）

### 访问方式

- HTTP: http://localhost:5678
- HTTPS (通过nginx): https://your-domain.com

默认登录：
- 用户名: admin
- 密码: 在 `.env` 文件中配置的 `N8N_BASIC_AUTH_PASSWORD`

### 数据持久化

- n8n 数据存储在 Docker volume `n8n_data` 中
- PostgreSQL 和 Redis 数据由外部服务管理

### 监控和维护

- 健康检查端点: `/healthz`
- 日志文件位置: `/home/node/.n8n/logs/`
- 执行数据保留: 14天

### 注意事项

1. 请务必修改默认密码
2. 生成强随机的加密密钥
3. 配置适当的防火墙规则
4. 定期备份 PostgreSQL 数据库
5. 监控服务运行状态和资源使用情况