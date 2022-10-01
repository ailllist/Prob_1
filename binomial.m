clear
clc

n = 100; % 시행 횟수
p = 0.2; % Bernoulli 확률 p
tot = 1000000; % Binomial r.v 생성 횟수

counting_arr = zeros(1, n+1); % 단일 Binomial r.v에서
% Event가 일어남을 기록하는 array
% 이때 index가 사건이 일어난 횟수에 대응되지만 Binomial r.v의 경우
% 사건이 일어나지 않을 수도 있기 때문에 index가 0인 경우를 고려하기 위
% 배열에 1칸의 여유공간을 두어 Event가 한번도 발생하지 않은 경우를 집어넣음
% 즉 index=1은 event가 0번 일어난 경우 index=2는 event가 1번 일어난 경우를
% 의미한다.
avg_arr = zeros(1, n+1); % counting_arr에서 추출한 확률을 저장하는 array
% PMF는 avg_arr를 plot한 결과물이다.
GT = zeros(1, n+1); % 수식을 통해 얻은 값
CDF_arr = zeros(1, n+1); % avg_arr를 통해 구한 CDF를 저장하는 array

for i = 1:tot % binomial r.v를 여러번 생성.
    count_sel = 0; % Event가 발생한 횟수를 기록하는 변수
    for j = 1:n % binomial r.v를 생성. n번의 시행을 한다.
        if rand(1) < p % bernoulli r.v로 접근하기에, 
            % rand(1)이 p보다 작은경우를 event가 발생한 경우로 본다.
            count_sel = count_sel + 1; % event가 발생하였기 때문에 count.
        else % 발생하지 않으면 넘어간다.
        end
    end
    counting_arr(count_sel+1) = counting_arr(count_sel+1) + 1;
    % counting_arr에 event가 발생한 횟수를 기록한다. 0 -> 1 (idx)이다.
end

for i = 1:length(avg_arr) % PMF 생성부
    probability = counting_arr(i) / tot; % i: event가 발생한 횟수 (i-1)
    % event가 발생한 횟수 / 전체 시행 횟수 = 확률로 보았다.
    avg_arr(i) = probability; % avg_arr, PMF에 확률 추가
    if (i==1) % CDF값을 구할 때 초기값은 없기 때문에
        CDF_arr(i) = probability; % 확률만 더한다
    else % 그 외에는
        CDF_arr(i) = CDF_arr(i-1) + probability; % 이전값을 참조하여
        % CDF값을 구한다.
    end
end

for i = 1:length(GT) % GT data 생성
    if i == 0 % 자연스러운 plot을 위해
        continue; % 1칸씩 민다.
    end
    GT(i) = comb(n, i-1)*(p^(i-1))*((1-p)^(n-(i-1)));
    % 수식에 기반해 Generation
end

plot_CDF_arr = zeros(1, n+3); % CDF를 그릴 때 event가 한번도 일어나지 
% 않은 경우에(idx=1) binomial은 확률이 대체로 0이 아니기 때문에 
% CDF를 더 이쁘기 그리기 위해 CDF값이 0 (x축: -2, -1)을 추가해 주었다.
for i = 1:length(plot_CDF_arr) % plot를 위한 CDF array 생성
    if i <= 2 % plot_CDF_array의 앞부분 2곳에
        plot_CDF_arr(i) = 0; % CDF값이 0임을 추가
    else % 그 외의 경우
        plot_CDF_arr(i) = CDF_arr(i-2); % CDF_arr의 값을 저장
    end
end

GT_CDF = zeros(1, n+3); % GT data를 토대로 CDF 생성
for i = 1:length(GT_CDF) % plot의 목적이므로 추가 작업 필요
    if i <= 2 % plot_CDF_arr와 구조를 유사하게 생성
        GT_CDF(i) = 0;
    else % CDF 생성
        if i == 3 
            GT_CDF(i) = GT(i-2);
        else
            GT_CDF(i) = GT(i-2) + GT_CDF(i-1);
        end
    end
end

y_max = max(avg_arr); % ylim을 위해 최대 확률을 구한다.

figure(1) % PMF plot
x = 0:length(avg_arr)-1; % x값을 0부터 시작하게끔 한다.
stem(x, avg_arr, "r") % discrete함을 잘 나타내는 stem함수를 사용하였다.
title("PMF, Binomial") % title 선언
xlim([-10, n + 10]) % binomial의 경우 모든 정의역을 볼 수 있도록 하였다.
ylim([-0.1, y_max + 0.1]) % 최대 확률보다 0.1만큼 더 보게끔 하였다.
xlabel("number of event") % x축 선언
ylabel("probability") % y축 선언

figure(2) % CDF plot
x = -2:length(CDF_arr)-1; % x축을 -2 ~ len(CDF_arr)-1만큼 하였다.
stairs(x, plot_CDF_arr) % 계단함수로 CDF를 plot
title("CDF, Binomial") % title 선언
xlabel("number of event") % x축 = event가 일어난 횟수
ylabel("CDF value") % y축 = CDF 값
ylim([-0.5, 1.5]) % CDF를 표현하기 적당한 y축 범위

figure(3) % GT data와의 비교
hold on % PMF (generated)와 GT data를 동시에 plot하기 위해 hold해줌
x = 0:length(avg_arr)-1; % x값을 0부터 시작하게끔 한다.
stem(x, avg_arr, "-.^r") % PMF를 그릴 때 GT data와의 명료한 비교를 위해
stem(x, GT, "--og") % -.^r, --og를 사용
legend(["generated", "GT"]) % legend
title("generated vs GT (Binomial, PMF)") % title 선언
xlim([-10, n + 10])
ylim([-0.1, y_max + 0.1]) % 최대 확률보다 0.1만큼 더 보게끔 하였다.
xlabel("number of event")
ylabel("probability")

figure(4) % GT data와의 비교 (CDF)
hold on
x = -2:length(CDF_arr)-1; % x축을 -2 ~ len(CDF_arr)-1만큼 하였다.
stairs(x, plot_CDF_arr, "-.^r")
stairs(x, GT_CDF, "--og")
ylim([-0.5 1.5])
legend(["generated", "GT"]) % legend
title("generated vs GT (Binomial, CDF)")
xlabel("number of event") % x축 = 성공여부 (0: 실패, 1: 성공)
ylabel("CDF value") % y축 = CDF 값