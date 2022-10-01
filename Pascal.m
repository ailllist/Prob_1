clear
clc
% raise는 빠르고 fall은 느림 
% Pascal의 경우 k = 1인 경우에만 0번째 idx가 필요한데
% 주어진 조건은 k = 2, 4, 6이므로 plot을 그냥 진행함.
k = 6; % pascal의 parameter인 k
p = 0.2; % bernoulli 확률 p
tot = 1000000; % 총 실행 횟수
cnt_arr = zeros(1, 200); % 사건이 일어남을 기록하는 array
avg_arr = zeros(1, 200); % % cnt_arr에서 추출한 확률을 저장하는 array
% PMF는 avg_arr를 plot한 결과물이다.
CDF_arr = zeros(1, 200); % avg_arr를 통해 구한 CDF를 저장하는 array
GT = zeros(1, 200); % 수식을 통해 얻은 값

for i = 1:tot % Pascal r.v를 여러번 생성
    cnt = 0; % 성공 횟수를 기록하는 변수
    idx = 0; % 시행 횟수를 기록하는 변수
    while(1) % k번 성공할 때까지 무한 반복
        if rand(1) < p % 성공한 경우
            cnt = cnt + 1; % 성공횟수를 증가시킨다
        else % 그 외는 넘어간다
        end
        idx = idx + 1; % 시행 횟수 증가
        if cnt == k % k번 성공한 경우
            break; % while loop를 중단시킨다.
        else
        end
    end
    cnt_arr(idx) = cnt_arr(idx) + 1; % cnt_arr에 시행 횟수를 기록한다.
    % 이 경우 index = n 인 경우 n회만에 k번 성공한 경우의 갯수를 의미한다.
end

for i = 1:length(cnt_arr) % avg_arr, PMF 생성부
    probability = cnt_arr(i) / tot; % i = i번만에 도달한 횟수
    % i번 만에 도달한 횟수 / 전체 시행횟수 = Pascal r.v 확률로 보았다.
    avg_arr(i) = probability; % avg_arr, PMF에 추가
    if (i==1) % CDF 생성, idx가 1인경우
        CDF_arr(i) = probability; % 이건 값이 없기에 확률을 넣는다.
    else % 그 외의 경우는
        CDF_arr(i) = CDF_arr(i-1) + probability; % 이전 값 + 확률
    end
end

for i = 1:length(GT) % GT data 생성
    if i < k % k번보다 적게 시행해 Pascal r,v가 생성될 수 없으므로
        continue; % 넘긴다
    else % 그 외의 경우
        res = comb(i - 1, k - 1)*(p^k)*((1-p)^(i-k));
        % 수식에 기반해 generation
        GT(i) = res; % GT에 저장
        if res <= 1e-10 % 값이 너무 작으면 오류가 난다 그래서 미리 끊어준다.
            break; 
        end
    end
end

GT_CDF = zeros(1, 200); % GT data를 토대로 CDF 생성
for i = 1:length(GT_CDF) % plot의 목적이므로 추가 작업 필요
    if i == 1 % CDF 생성
        GT_CDF(i) = GT(i);
    else
        GT_CDF(i) = GT(i) + GT_CDF(i-1);
    end
end

y_max = max(avg_arr); % ylim을 위해 최대 확률을 구한다.

figure(1) % PMF plot
stem(avg_arr, "r") % discrete 하므로 stem함수를 통해 그래프를 나타내었다.
title("PMF, Pascal") % title 선언
xlim([-10, 100]) % ~100이내로 제한
ylim([-0.02, y_max + 0.1]) % 최대 확률 + 0.1을 통해 y값 제한
xlabel("number of trials") % x축 = 시행 횟수
ylabel("probability") % 확률

figure(2) % CDF plot
stairs(CDF_arr) % 계단함수로 CDF를 plot
title("CDF, Pascal") % title 선언
xlim([-10, 100]) % ~100이내로 제한
ylim([-0.5, 1.5]) % 0~1 사이에 CDF value가 분포하므로 적절한 값 설정
xlabel("number of trials") % x축 = 시행 횟수
ylabel("CDF value") % y축 = CDF 값

figure(3) % GT data와의 비교
hold on % PMF (generated)와 GT data를 동시에 plot하기위해 hold해줌
stem(avg_arr, "-.^r") % GT data와의 깔끔한 비교를 위해
stem(GT, "--og") % -.^r, --og로 그래프를 그림
legend(["generated", "GT"]) % legend
title("generated vs GT (Pascal, PMF)") % title 선언
xlim([-10, 100]) % ~100이내로 제한
ylim([-0.02, y_max + 0.1]) % PMF와 마찬가지로 제한
xlabel("number of trials") % x축 = 시행 횟수
ylabel("probability") % y축 = 확률

figure(4) % GT data와의 비교 (CDF)
hold on
stairs(CDF_arr, "-.^r")
stairs(GT_CDF, "--og")
xlim([-10, 100]) % ~100이내로 제한
ylim([-0.5 1.5])
legend(["generated", "GT"]) % legend
title("generated vs GT (Pascal, CDF)")
xlabel("number of trials") % x축 = 성공여부 (0: 실패, 1: 성공)
ylabel("CDF value") % y축 = CDF 값