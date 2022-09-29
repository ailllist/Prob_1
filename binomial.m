clear
clc

n = 20;
p = 0.2;
tot = 1000000;

counting_arr = zeros(1, n+1);
avg_arr = zeros(1, n+1);
GT = zeros(1, n+1);
CDF_arr = zeros(1, n+1);

for i = 1:tot
    count_sel = 0;
    for j = 1:n
        if rand(1) < p
            count_sel = count_sel + 1;
        else
        end
    end
    counting_arr(count_sel+1) = counting_arr(count_sel+1) + 1;
end

for i = 1:length(avg_arr)
    probability = counting_arr(i) / tot;
    avg_arr(i) = probability;
    if (i==1)
        CDF_arr(i) = probability;
    else
        CDF_arr(i) = CDF_arr(i-1) + probability;
    end
end

for i = 1:length(GT)
    if i == 0
        continue;
    end
    GT(i) = comb(n, i-1)*(p^(i-1))*((1-p)^(n-(i-1)));
end

plot_CDF_arr = zeros(1, n+3); % CDF를 그릴 때 event가 한번도 일어나지 
% 않은 경우에(idx=1) poisson은 확률이 대체로 0이 아니기 때문에 
% CDF를 더 이쁘기 그리기 위해 CDF값이 0 (x축: -2, -1)을 추가해 주었다.
for i = 1:length(plot_CDF_arr) % plot를 위한 CDF array 생성
    if i <= 2 % CDF array의 앞부분 2곳에
        plot_CDF_arr(i) = 0; % CDF값이 0임을 추가
    else % 그 외의 경우
        plot_CDF_arr(i) = CDF_arr(i-2); % CDF_arr의 값을 저장
    end
end

err_arr = GT - avg_arr;

figure(1)
x = 0:length(avg_arr) - 1;
stem(x, avg_arr, "r")
title("PMF, Binomial")
xlim([-10, n + 10])
ylim([-0.1, 0.2])
xlabel("number of event")
ylabel("probability")

figure(2)
x = -2:length(CDF_arr)-1;
stairs(x, plot_CDF_arr)
title("CDF, Binomial")
xlabel("number of event") % x축 = event가 일어난 횟수
ylabel("CDF value") % y축 = CDF 값
ylim([-0.5, 1.5])

figure(3)
hold on
x = 0:length(avg_arr) - 1;
stem(x, avg_arr, "-.^r")
stem(x, GT, "--og")
legend(["generated", "GT"])
title("generated vs GT")
xlim([-10, n + 10])
ylim([-0.1, 0.2])
xlabel("number of event")
ylabel("probability")