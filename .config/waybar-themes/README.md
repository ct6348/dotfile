# Waybar 主题集 · 三套风格各异的配置

直接可用的 Waybar v0.15.0 配置，覆盖三种完全不同的视觉风格。

---

## 风格对比

| 特性 | 🟤 Gruvbox | 🟣 Catppuccin | 🔵 Tokyo Night |
|------|-----------|--------------|----------------|
| **风格** | 暖色经典 | 现代简约 | 赛博深蓝 |
| **基底** | 深色暖调 `#1d1c19` | 紫灰调 `#1e1e2e` | 半透蓝黑 `rgba(26,27,38,0.75)` |
| **模块边缘** | 圆角 8px + 渐变色底 | 锐利直角 + 细边框 | 圆角 12px + 霓虹发光 |
| **背景效果** | 纯色渐变 | 纯色 + 颜色边框 | 毛玻璃透明 + box-shadow 发光 |
| **高度** | 34px（标准） | 28px（紧凑） | 32px（标准） |
| **字体大小** | 12px | 11px | 12px |
| **布局** | 左: 工作区+任务栏 / 右: 全部 | 左: 仅工作区 / 右: 紧凑模块 | 左: 启动器+工作区 / 中: 时钟 / 右: 全部 |
| **模块数量** | 15 个 | 10 个 | 14 个 |
| **hover 效果** | 颜色渐变 | 背景变亮 | 发光边框 + shadow |
| **中文字体** | Maple Mono NF CN + Noto Sans CJK SC | Maple Mono NF CN | Maple Mono NF CN + Noto Sans CJK SC |
| **适用场景** | 全功能主力机 | 笔记本 / 小屏幕 | 追求视觉效果 |

---

## 快速使用

```bash
# 1. 备份当前配置
mv ~/.config/waybar ~/.config/waybar.bak

# 2. 选择一套主题
cp -r waybar-themes/gruvbox ~/.config/waybar     # Gruvbox
# cp -r waybar-themes/catppuccin ~/.config/waybar  # Catppuccin
# cp -r waybar-themes/tokyo-night ~/.config/waybar # Tokyo Night

# 3. 重启 waybar
killall waybar && waybar &
```

---

## 依赖检查

运行各主题前，请确保已安装所需依赖：

```bash
# 核心依赖（三套都需要）
sudo pacman -S waybar mako networkmanager pamixer brightnessctl wlogout fuzzel

# 可选依赖
sudo pacman -S blueman                     # 蓝牙管理（Gruvbox / Tokyo Night）
sudo pacman -S pipewire-pulse pulseaudio   # 音频后端（之一即可）

# 字体
# Maple Mono NF CN: https://github.com/subframe7536/maple-font
# 或从 AUR 安装
yay -S maple-font
```

### 各主题依赖清单

| 模块 | Gruvbox | Catppuccin | Tokyo Night |
|------|---------|------------|-------------|
| `waybar` | ✅ | ✅ | ✅ |
| `mako` + `makoctl` | ✅ | ✅ | ✅ |
| `pamixer` + `pipewire-pulse`/`pulseaudio` | ✅ | ✅ | ✅ |
| `networkmanager` | ✅ | ✅ | ✅ |
| `brightnessctl` | ✅ | ✅ | ✅ |
| `blueman` | ✅ | ❌ | ✅ |
| `wlogout` | ✅ | ✅ | ✅ |
| `fuzzel` | ✅（任务栏忽略） | ❌ | ✅（启动器） |

---

## 模块行为说明

### 时钟
- **点击**：在 `format` / `format-alt` 之间切换
- **Gruvbox**：默认 → `星期四 06/19`，alt → `15:30:45 06/19`
- **Catppuccin**：默认 → `06/19 15:30`，alt → `星期四 06/19 15:30`
- **Tokyo Night**：默认 → `星期四 06/19  /  15:30:45`，alt → `2025-06-19 15:30:45`

### 音量
- 左键点击：静音/取消静音（`pamixer -t`）
- 滚轮上/下：增/减 5%（`pamixer -i 5` / `pamixer -d 5`）

### 亮度
- 滚轮上/下：增/减 5%（`brightnessctl s +5%` / `s 5%-`）

### 网络
- **Gruvbox/Tokyo Night**：点击打开网络管理器
- **Catppuccin**：无点击事件（纯显示）

### 蓝牙
- **Gruvbox/Tokyo Night**：点击打开 `blueman-manager`

### 通知
- 有通知时图标变黄/橙色
- 点击清除所有通知（`makoctl dismiss -a`）

### 电源
- 点击打开 `wlogout` 关机菜单

---

## 自定义指南

### 切换显示器/背光设备

```json
// 查找你的背光设备
ls /sys/class/backlight/
// 修改 backlight 模块
"backlight": { "device": "你的设备名", ... }
```

### 调整温度传感器

```json
// 查找热区
ls /sys/class/thermal/
// 修改 temperature 模块
"temperature": { "thermal-zone": 0, ... }
```

### 调整字体

在每套主题的 `style.css` 中修改 `font-family`：

```css
* {
    font-family: "你的字体", "Fallback Font", sans-serif;
}
```

### 调整间距

| 参数 | 位置 | 说明 |
|------|------|------|
| `height` | `config.jsonc` 顶层 | 整体高度 |
| `margin-*` | `config.jsonc` 顶层 | 外间距 |
| `spacing` | `config.jsonc` 顶层 | 模块间距 |
| `padding` | `style.css` 各模块 | 模块内间距 |
| `margin` | `style.css` 各模块 | 模块间间距 |

---

## 踩坑备忘（来自实战）

详见 `.reasonix/skills/waybar-config-guide/SKILL.md`，关键点：

1. 🚫 时钟不要写多个 `{}` 块 → 只用一个 `{:%...}`
2. 🚫 电池 `tooltip-format` 不支持 `{status}` → 只用 `{capacity}`
3. 🚫 磁盘不要写 `{used:GiB}` → 用 `{used}` 自动换算
4. 🚫 通知不要用 `swaync-client` → 用 `makoctl`
5. ✅ 点击切换时宽度固定 → CSS 设 `min-width` 包住两种视图

---

## 附加配置：wlogout 电源菜单

每个主题附带 `wlogout.css`，解决点击电源按钮时的 Gtk-CRITICAL 报错：

```bash
# 安装 wlogout 样式
cp waybar-themes/tokyo-night/wlogout.css ~/.config/wlogout/style.css
# 或 gruvbox / catppuccin，选你用的主题
```

**关于 `-b` 参数**：Tokyo Night 用 `wlogout -b 3`（3 列 × 2 行，适配 6 个默认按钮），其他主题用 `wlogout` 使用默认布局。

---

## 主题文件结构

```
waybar-themes/
├── README.md              ← 本文件
├── gruvbox/               🟤 暖色经典
│   ├── config.jsonc
│   ├── style.css
│   └── wlogout.css        ← 电源菜单样式
├── catppuccin/            🟣 现代简约
│   ├── config.jsonc
│   ├── style.css
│   └── wlogout.css        ← 电源菜单样式
└── tokyo-night/           🔵 赛博深蓝
    ├── config.jsonc
    ├── style.css
    └── wlogout.css         ← 电源菜单样式
```
