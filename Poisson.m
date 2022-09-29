clear
clc

alp = 1; % 평균적으로 발생하는 Event
n = 100000; % slot의 개수
p = alp/n; % p, alp는 전체 기간동안 발생하는 Event의 수 이므로
% n으로 나누면 확률에 근사할 것이라 생각해 alp/n을 확률로 삼음
tot = 10000; % poisson r.v 생성 횟수

counting_arr = zeros(1, n+1); % 단일 poisson r.v에서 
% 사건이 일어남을 기록하는 array
% 이때 index가 사건이 일어난 횟수에 대응되지만 poisson r.v의 경우
% 사건이 일어나지 않을수도 있기 때문에 index가 0인 경우를 고려하기 위해
% 배열에 1칸의 여유공간을 두어 한번도 event가 발생되지 않은 경우를 집어넣음
avg_arr = zeros(1, n+1); % counting_arr에서 추출한 확률을 저장하는 array
% PMF는 avg_arr를 plot한 결과물이다.
CDF_arr = zeros(1, n+1); % avg_arr를 통해 구한 CDF를 저장하는 array
GT = zeros(1, n+1); % 수식을 통해 얻은 값

for i = 1:tot % poisson r.v를 여러번 생성.
    count_sel = 0; % Event가 발생한 횟수를 기록하는 변수
    for j = 1:n % poisson r.v 생성. 관측 기간을 n개로 쪼개어 binomial로 접근
        if rand(1) < p % bernolli r.v로 접근하기에, 
            % rand(1) 이 p보다 작은경우를 Event가 발생한 경우로 봄
            count_sel = count_sel + 1; % Event가 발생하였기 때문에 count
        else % 발생하지 않으면 넘어간다.
        end
    end
    counting_arr(count_sel+1) = counting_arr(count_sel+1) + 1;
    % counting_arr에 Event가 발생한 횟수 기록, 0 -> 1 (idx)로 match시켰다.
    i % 코드 실행이 오래걸리기 때문에 진행상황 체크용도
end

for i = 1:length(avg_arr) % avg_arr, PMF 생성부
    probability = counting_arr(i) / tot; % i = Event가 발생한 횟수 (i-1)
    % Event가 발생한 횟수 / 전체 시행 횟수 = poisson r.v 확률로 보았다.
    avg_arr(i) = probability; % avg_arr, PMF에 추가
    if (i==1) % CDF 생성, idx가 1인 경우
        CDF_arr(i) = probability; % 이전 값이 없기에 확률을 넣는다.
    else % 그 외인 경우는
        CDF_arr(i) = CDF_arr(i-1) + probability; % 이전 값 + 확률
    end
end

for i = 1:length(GT) % GT data 생성
    if i == 0 % 자연스러운 plot을 위해
        continue; %  1칸씩 민다.
    end
    GT(i) = (alp^(i-1))*((exp(-alp))/factorial(i-1));
    % 수식에 기반해 generation, 마찬가지로 i=1인 경우가 
    % event가 한번도 일어나지 않은 경우를 나타낸다.
end

plot_CDF_arr = zeros(1, n+3); % CDF를 그릴 때 event가 한번도 일어나지 
% 않은 경우에(idx=1) poisson은 확률이 대체로 0이 아니기 때문에 
% CDF를 더 이쁘기 그리기 위해 CDF값이 0 (x축: -2, -1)을 추가해 주었다.
for i = 1:length(plot_CDF_arr) % plot를 위한 CDF array 생성
    if i <= 2 % plot_CDF_array의 앞부분 2곳에
        plot_CDF_arr(i) = 0; % CDF값이 0임을 추가
    else % 그 외의 경우
        plot_CDF_arr(i) = CDF_arr(i-2); % CDF_arr의 값을 저장
    end
end

figure(1) % PMF plot
x = 0:length(avg_arr)-1; % x값을 0부터 시작하게끔 한다.
stem(x, avg_arr, "r") % discrete 하므로 
% discrete를 가장 잘 나타내는 stem함수를 통해 나타내었다.
title("PMF, Poisson") % title 선언
xlabel("number of event") % x축 = event가 일어난 횟수
ylabel("probability") % y축 = 확률
xlim([-10, 100]) % 대채로 ~100까지 범위안에 모든 값이 분포
ylim([-0.1, 0.5]) % 대체로 ~0.5안에 확률이 분포

figure(2) % CDF plot
x = -2:length(CDF_arr)-1; % x축을 -2 ~ len(CDF_arr)-1로 설정
stairs(x, plot_CDF_arr) % 계단함수가로 CDF를 plot
title("CDF, Poisson") % title 선언
xlim([-10, 100]) % PMF와 마찬가지로 ~100이내로 제한
ylim([-0.5, 1.5]) % 0~1사이에 CDF value가 분포하므로 적절한 값 설정
xlabel("number of event") % x축 = event가 일어난 횟수
ylabel("CDF value") % y축 = CDF 값

figure(3) % GT data와의 비교
hold on % PMF (generated)와 GT data를 동시에 plot하기 위해 hold해줌
x = 0:length(avg_arr)-1; % x값을 0부터 시작하게끔 한다.
stem(x, avg_arr, "-.^r") % PMF를 그릴 때 GT data와의 명료한 비교를 위해
stem(x, GT, "--og") % -.^r, --og를 사용
legend(["generated", "GT"]) % legend
title("generated vs GT (Poisson)") % title 선언
xlim([-10, 100]) % ~100이내로 제한
ylim([-0.1, 0.5]) % PMF와 마찬가지로 ~0.5로 제한
xlabel("number of event") % x축 = event가 일어난 횟수
ylabel("probability") % y축 = 확률