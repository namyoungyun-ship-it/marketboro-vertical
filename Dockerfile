# 판교 거래액 대시보드 — 정적 파일을 nginx로 서빙
# ALB 헬스체크: nginx 기본 설정이 "/" 요청에 index.html을 200으로 반환한다.
FROM nginx:1.27-alpine

# 기본 문서 루트에 대시보드 배치
COPY index.html /usr/share/nginx/html/index.html

# Devtron/ALB가 바라보는 컨테이너 포트
EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://127.0.0.1/ >/dev/null 2>&1 || exit 1

CMD ["nginx", "-g", "daemon off;"]
