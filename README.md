# Spark Docker 환경

이 Dockerfile은 Spark 3.5.4, Java 11, Python 3.10 가상환경을 기반으로 구성된 단일 노드 개발용 Spark 컨테이너를 구성


## 📁 기본 디렉토리

- Spark 설치 경로: `/usr/local/spark`
- 기본 작업 디렉토리: `/usr/local`


## ✅ 구성 요소 버전

| 구성 요소 | 버전 |
|-----------|-------|
| Ubuntu    | 20.04 |
| Java      | 11 (OpenJDK) |
| Python    | 3.10 + venv |
| Spark     | 3.5.4 |
| PySpark   | 3.5.4 |


## 🐳 컨테이너 실행 방법

```bash
docker build -t my-spark-env .
```

- 마운트 X
```bash
docker run -it -p 8082:8082 my-spark-env
```

- 마운트 O
```bash
docker container run --interactive --tty --name spark_test_1 -p 8082:8082 --mount type=bind,source="$(pwd)/practice",destination=/usr/local/practice spark_test
```

- `-p 8082:8082`은 **Spark Master Web UI** 포트입니다. 로컬 브라우저에서 확인 가능:  
  👉 http://localhost:8082


## 🔧 컨테이너 내부 - Spark 시작 명령어 (터미널에서 실행)

컨테이너 진입 후 아래 명령어들을 실행해 Spark를 시작합니다:

```bash
$SPARK_HOME/sbin/start-master.sh
$SPARK_HOME/sbin/start-worker.sh spark://localhost:7077
```


## 🌐 Web UI 정보

- Spark Master Web UI: [http://localhost:8082](http://localhost:8082)
  - 포트는 `spark-env.sh`에서 아래와 같이 설정:

    ```bash
    export SPARK_MASTER_WEBUI_PORT=8082
    ```

- Spark Worker는 별도로 포트 바인딩 되어 있지 않으며, 내부에서 마스터에 attach 됩니다.
