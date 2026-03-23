# --- GIAI ĐOẠN 1: BUILD ---
FROM maven:3.9.9-eclipse-temurin-21 AS builder

WORKDIR /app

COPY . .

# Biên dịch code thành file .jar (bỏ qua chạy thử test để build nhanh)
RUN mvn package -DskipTests

# --- GIAI ĐOẠN 2: RUN ---
FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

# Chỉ lấy file .jar từ builder (GĐ1)
COPY --from=builder /app/target/*.jar app.jar

# Container cần lắng nghe cổng 80 theo yêu cầu của server deploy
EXPOSE 80
ENV SERVER_PORT=80

# Lệnh "bật công tắc" để chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]
