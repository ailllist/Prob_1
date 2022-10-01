clear
clc

p = 0.7; % Bernoulli 확률 p

Y = zeros(1, 100000); % Bernoulli 시행 결과를 기록하는 array
GT = zeros(1, 2); % 수식을 통해 얻은 값
GT_CDF = zeros(1, 2);

cnt = 1; % 반복 횟수를 기록하는 변수
while (cnt < length(Y)) % Y만큼 반복
    x = rand(1); % 0~1사이의 랜덤한 수 추출
    if x <= p % 성공한 경우
        Y(cnt) = 1; % 성공으로 기록
    else % 그 외는
        Y(cnt) = 0; % 실패로 기록
    end
    cnt = cnt + 1; % 반복 횟수 증가
end

avg = sum(Y)/length(Y); % 전체 결과의 평균값을 구한다.

GT = [1-p p]; % 수식을 통해 Generation한 값, PMF
GT_CDF = [0, 1-p, 1, 1]; % 수식을 통해 Generation한 값, CDF

oat = [1-avg avg]; % PMF를 그리기 위한 array
obt = [0 1]; % x축 공간 정의 
CDF_arr = [0, 1-avg, 1, 1]; % CDF를 그리기 위한 array

figure(1) % PMF plot
stem([0 1], oat); % discrete함을 잘 나타내는 stem함수를 사용하였다.
xlim([-0.5 1.5]) % PMF 값을 출력하기에 적절한 x범위
ylim([-0.5 1.5]) % PMF 값을 출력하기에 적절한 y범위
title("PMF, Bernoulli") % title 선언
xlabel("number of event") % x축 = 성공여부 (0: 실패, 1: 성공)
ylabel("probability") % y축 = 확률

figure(2) % CDF plot
stairs([-1 0 1 2], CDF_arr) % 계단함수로 CDF를 plot
ylim([-0.5 1.5]) % CDF를 표현하기 적당한 y축 범위
title("CDF, Bernoulli") % title 선언
xlabel("number of event") % x축 = 성공여부 (0: 실패, 1: 성공)
ylabel("CDF value") % y축 = CDF 값

figure(3) % GT data와의 비교 (PMF)
hold on % PMF (generated)와 GT data를 동시에 plot하기 위해 hold해줌
x = [0 1]; % x 범위 재설정
stem(x, oat, "-.^r") % PMF를 그릴 때 GT data와의 명료한 비교를 위해
stem(x, GT, "--og") % -.^r, --og를 사용
xlim([-0.5, 1.5]) % PMF와 같은 범위
ylim([-0.5, 1.5]) % PMF와 같은 범위
legend(["generated", "GT"]) % legend
title("generated vs GT (Bernoulli, PMF)") % title 선언
xlabel("number of event") % x축 = 성공여부 (0: 실패, 1: 성공)
ylabel("probability") % y축 = 확률

figure(4) % GT data와의 비교 (CDF)
hold on
stairs([-1 0 1 2], CDF_arr, "-.^r")
stairs([-1 0 1 2], GT_CDF, "--og")
ylim([-0.5 1.5])
legend(["generated", "GT"]) % legend
title("generated vs GT (Bernoulli, CDF)")
xlabel("number of event") % x축 = 성공여부 (0: 실패, 1: 성공)
ylabel("CDF value") % y축 = CDF 값
