# 판교 거래액 대시보드 — 정적 파일을 nginx로 서빙
# Devtron 표준 차트가 컨테이너 포트 8080을 기대하므로 8080에서 리슨한다.
# ALB/프로브 헬스체크: nginx가 "/" 요청에 index.html을 200으로 반환한다.
FROM nginx:1.27-alpine

# 8080 리슨 서버 블록으로 기본 설정 교체
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 문서 루트에 대시보드 배치
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://127.0.0.1:8080/ >/dev/null 2>&1 || exit 1

CMD ["nginx", "-g", "daemon off;"]
