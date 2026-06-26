# 🌐 Container Network MyConfig 🚀

> **一套基于 Podman 的容器网络统一管理方案**。通过声明式配置，实现容器间的**精准通信**与**安全隔离**。

---

## 🏗️ 1. 网络架构设计 (Topology)

我们采用“分区治理”的思路，将网络划分为四个核心安全等级，像剥洋葱一样保护您的核心数据。层级化管理让您的容器不再是“大锅饭”。

| 网络名称 | 安全等级 | 🎨 图标 | 用途描述 | 核心特性 |
| :--- | :--- | :--- | :--- | :--- |
| `net-edge` | **Public** | 🌍 | 面向外部的网关 (Nginx, UI) | 允许外网入站，唯一的对外窗口。 |
| `net-infra` | **Shared** | 🔌 | 公共基础组件 (Redis, MQ) | 跨应用共用，作为所有 App 的“公共插座”。 |
| `net-app-xxx` | **Local** | 📱 | 特定应用的业务逻辑层 | 仅限该 App 内部通信，防止横向渗透。 |
| `net-db-private`| **Isolated**| 🔒 | 核心数据存储 (DB) | **禁止访问互联网** (`internal`)，极高安全性。 |

---

## 🛠️ 2. 如何管理网络 (推荐方式)

我们坚持 **Infrastructure as Code (IaC)** 理念，使用 YAML 声明式管理网络。

### 🚀 初始化 / 同步网络
当您需要创建或更新全局网络时：

```bash
cd ~/.config/containers/myconfig/networks
podman-compose -f infrastructure.yml up -d
```

> **💡 专家提示**：YAML 方式能够像文档一样记录网络状态。即使多次运行，Podman 也只会应用“差异”部分，稳如泰山。

### 📜 传统脚本方式 (备选)

在没有 Compose 环境或需要极致自动化的 CI/CD 流程中：
`./networks/setup-core-networks.sh`

---

## 📝 3. 使用模板 (How to use)

在您的项目 `docker-compose.yml` 中，只需轻松两步即可接入管理体系。

### 第一步：服务配置
```yaml
services:
  web-api:
    image: my-service
    networks:
      - net-edge        # 🌍 接入网关，以便外部访问
      - net-db-private  # 🔒 接入隔离数据库层
      - net-infra       # 🔌 访问公共 Redis
```

### 第二步：引用外部网络
```yaml
networks:
  net-edge:       { external: true }
  net-db-private: { external: true }
  net-infra:      { external: true }
```

---

## 🌟 4. 常见场景最佳实践

- **🤝 容器间通信**：只要在一个网络中，直接通过 `container_name` 互访，告别 IP 地址。
- **🏗️ 独立 App 部署**：为它创建一个本地网络，同时只连接它需要的 `net-infra` 或 `net-edge`。
- **🛡️ 数据库防爆**：务必将数据库仅放在 `net-db-private`。由于该网络是 `internal` 类型，即便数据库被黑，黑客也无法将其作为跳板向外拉取数据请求。
- **⚡ 性能优先**：尽量减少不跨网段的通信。

---

## 🔧 5. 维护常用命令库

| 命令 | 作用 |
| :--- | :--- |
| `podman network ls` | 查看所有网络 |
| `podman network inspect net-infra` | 查看哪些容器“插”在了公共网络上 |
| `podman network prune` | 清理那些没人用的“僵尸”网络 |
| `podman exec -it <name> ping <other>` | 连通性终极测试 |

---

## ❓ 6. 为什么这么设计？

我们放弃了传统的“一个 App 一个网络”的混乱做法，转而采用**全局统一分层**。
- **低耦合**：数据库不联网，逻辑层不暴露，网关不存数。
- **高复用**：一次定义 `net-infra`，百个应用共享。
- **易维护**：所有的网络变动都在 `infrastructure.yml` 里，一目了然。

---
祝您的容器运行愉快！ 🐳✨
