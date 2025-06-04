FROM python:3.9-slim

# 시스템 패키지
RUN apt-get update && apt-get install -y \
    ffmpeg libsm6 libxext6 libgl1-mesa-glx git curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# workdir 설정
WORKDIR /app

# 파일 복사
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Streamlit 포트 노출
EXPOSE 8501

# Streamlit 실행
CMD ["streamlit", "run", "app/main.py", "--server.port=8501", "--server.address=0.0.0.0", "--server.headless=true"]
