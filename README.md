# aisdk.channels

Messaging-channel integrations for the
[aisdk](https://github.com/YuLab-SMU/aisdk) toolkit.

Connect `aisdk` agents to instant-messaging platforms (such as Feishu/Lark):
a channel runtime and adapters, webhook handling, event processing,
per-conversation session stores, and document ingestion.

## Installation

```r
# install.packages("remotes")
remotes::install_github("YuLab-SMU/aisdk")           # core
remotes::install_github("YuLab-SMU/aisdk.channels")  # this package
```

## Usage

```r
library(aisdk)
library(aisdk.channels)

# Interactive setup for a Feishu channel
setup_feishu_channel()
```

`pdftools` is optional (`Suggests`); a Python fallback is used for PDF ingestion
when it is not installed.
