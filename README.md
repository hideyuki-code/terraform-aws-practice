# terraform-aws-practice

このプロジェクトはAWSインフラをTerraformで構築する練習用リポジトリです。

## インフラ構成図

```mermaid
graph TD
    inet(("インターネット"))
    vpc["AWS VPC環境<br>10.0.0.0/16"]
    
    inet -.-> vpc
    
    subgraph AWS Cloud
        vpc
    end
    
    style vpc fill:#FF9900,stroke:#232F3E,stroke-width:2px
    style inet fill:#dae8fc,stroke:#6c8ebf,stroke-width:2px