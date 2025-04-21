# Spark Docker 환경

이 Dockerfile은 Spark 3.5.4, Java 11, Python 3.10 가상환경을 기반으로 구성된 단일 노드 개발용 Spark 컨테이너를 구성

## 🐳 컨테이너 실행 방법

```bash
docker build -t my-spark-env .
 docker container run -it --name spark1_c --mount type=bind,source=$(pwd),destination=/opt/workspace/ my-spark-env
```