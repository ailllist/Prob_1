clear
clc

p = 0.2; % Bernoulli 확률 p
n = 1000000; % 총 시행 횟수 n
cnt_arr = zeros(1, 101); % 단일 Geometric r.v에서 
% 사건이 일어남을 기록하는 array
% 이때 index가 사건이 일어난 횟수에 대응되지만 Geometric r.v의 경우
% 1번 성공한 경우가 존재할 수 있는데, 이 경우 CDF를 그릴때 0부터 시작하지 않아
% 0부터 시작하도록 0번만에 성공한 횟수를 집어넣어 0부터 시작되게 하였다.
% CDF_arr만 건들여도 되지만, 다른 코드와의 비슷하게 코딩하다보니 모든 배열에
% 길이 +1을 해서 코딩을 진행하였다.
avg_arr = zeros(1, 101); % cnt_arr에서 추출한 확률을 저장하는 array
% PMF는 avg_arr를 plot한 결과물이다.
CDF_arr = zeros(1, 101); % avg_arr를 통해 구한 CDF를 저장하는 array
GT = zeros(1, 101); % 수식을 통해 얻은 값

for i = 1:n % Geometric을 여러번 생성
    cnt = 1; % 시행 횟수를 측정하는 변수
    while (1) % 성공할 때까지 loop를 구성한다.
        if rand(1) < p % 성공한 경우
            break; % loop를 종료한다.
        else
        end
        cnt = cnt + 1; % 시행 횟수 증가
    end
    cnt_arr(cnt+1) = cnt_arr(cnt+1) + 1; % 시행 횟수에 대응되는 index에
    % 해당 시행횟수만에 완료된 횟수를 기록한다.
end

for i = 1:length(avg_arr) % avg_arr, PMF 생성부
    probability = cnt_arr(i) / n; % i = 시행 횟수
    % i번 만에 도달한 횟수 / 전체 시행횟수 = Geometric r.v 확률로 보았다.
    avg_arr(i) = probability; % avg_arr, PMF에 추가
    if (i==1) % CDF 생성, idx가 1인 경우
        CDF_arr(i) = probability; % 이전 값이 없기에 확률만을 넣는다.
    else % 그 외의 경우는
        CDF_arr(i) = CDF_arr(i-1) + probability; % 이전 값 + 확률
    end
end

for i = 1:length(GT) % GT data 생성
    if i == 1 % 1번째 index는 0번만에 성공할 확률이기에
        continue; % 넘긴다.
    end
    GT(i) = (1-p)^(i-1-1)*p; % 수식에 기반해 generation
end

plot_CDF_arr = zeros(1, 101);
for i = 1:length(plot_CDF_arr) % plot를 위한 CDF array 생성
    if i <= 1 % CDF array의 앞부분 1곳에
        plot_CDF_arr(i) = 0; % CDF값이 0임을 추가
    else % 그 외의 경우
        plot_CDF_arr(i) = CDF_arr(i-1); % CDF_arr의 값을 저장
    end
end

GT_CDF = zeros(1, 101); % GT data를 토대로 CDF 생성
for i = 1:length(GT_CDF) % plot의 목적이므로 추가 작업 필요
    if i <= 1 % plot_CDF_arr와 구조를 유사하게 생성
        GT_CDF(i) = 0;
    else % CDF 생성
        if i == 3
            GT_CDF(i) = GT(i-1);
        else
            GT_CDF(i) = GT(i-1) + GT_CDF(i-1);
        end
    end
end

y_max = max(avg_arr); % ylim을 위해 최대 확률을 구한다.

figure(1) % PMF plot
x = 0:length(avg_arr) - 1; % x 값을 0부터 시작하게 하였다.
stem(x, avg_arr, "r") % discrete하므로 stem함수를 통해 그래프를 나타내었다.
title("PMF, Geometric") % title 선언
ylim([-0.1, y_max + 0.1]) % 최대 확률 + 0.1을 통해 y값 제한
xlabel("number of trials") % x축 = 시행 횟수
ylabel("probability") % y출 = 획률

figure(2) % CDF plot
x = 0:length(CDF_arr)-1; % x 값을 0부터 시작하게 하였다.
stairs(x, plot_CDF_arr) % 계단함수로 CDF를 plot
title("CDF, Geometric") % title 선언
ylim([-0.5, 1.5]) % 0~1사이에 CDF value가 분포하므로 적절한 값 설정
xlabel("number of trials") % x축 = 시행 횟수
ylabel("CDF value") % y축 = CDF 값

figure(3) % GT data와의 비교
hold on % % PMF (generated)와 GT data를 동시에 plot하기 위해 hold해줌
x = 0:length(avg_arr) - 1; % x값을 0부터 시작하게끔 한다.
stem(x, avg_arr, "-.^r") % PMF를 그릴 때 GT data와의 명료한 비교를 위해
stem(x, GT, "--og") % -.^r, --og를 사용
legend(["generated", "GT"]) % legend
title("generated vs GT (Geometric, PMF)") % title 선언
ylim([-0.1, y_max + 0.1]) % 최대 확률 + 0.1을 통해 y값 제한
xlabel("number of trials") % x축 = 시행 횟수
ylabel("probability") % y축 = 확률

figure(4) % GT data와의 비교 (CDF)
hold on
x = 0:length(CDF_arr)-1; % x축을 -2 ~ len(CDF_arr)-1만큼 하였다.
stairs(x, plot_CDF_arr, "-.^r")
stairs(x, GT_CDF, "--og")
ylim([-0.5 1.5])
legend(["generated", "GT"]) % legend
title("generated vs GT (Geometric, CDF)")
xlabel("number of trials") % x축 = 성공여부 (0: 실패, 1: 성공)
ylabel("CDF value") % y축 = CDF 값