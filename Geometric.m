clear
clc

p = 0.5;
n = 1000000;
cnt_arr = zeros(1, 101);
avg_arr = zeros(1, 101);
CDF_arr = zeros(1, 101);
GT = zeros(1, 101);

for i = 1:n
    cnt = 1;
    while (1)
        if rand(1) < p
            break;
        else
        end
        cnt = cnt + 1;
    end
    cnt_arr(cnt+1) = cnt_arr(cnt+1) + 1;
end

for i = 1:length(avg_arr)
    probability = cnt_arr(i) / n;
    avg_arr(i) = probability;
    if (i==1)
        CDF_arr(i) = probability;
    else
        CDF_arr(i) = CDF_arr(i-1) + probability;
    end
end

for i = 1:length(GT)
    if i == 1
        continue;
    end
    GT(i) = (1-p)^(i-1-1)*p;
end

plot_CDF_arr = zeros(1, 101);
for i = 1:length(plot_CDF_arr) % plot를 위한 CDF array 생성
    if i <= 1 % CDF array의 앞부분 1곳에
        plot_CDF_arr(i) = 0; % CDF값이 0임을 추가
    else % 그 외의 경우
        plot_CDF_arr(i) = CDF_arr(i-1); % CDF_arr의 값을 저장
    end
end

figure(1)
x = 0:length(avg_arr) - 1;
stem(x, avg_arr, "r")
title("PMF, Geometric")
ylim([-0.1, 0.3])
xlabel("number of event")
ylabel("probability")

figure(2)
x = 0:length(CDF_arr)-1;
stairs(x, plot_CDF_arr)
title("CDF, Geometric")
ylim([-0.2, 1.2])

figure(3)
hold on
x = 0:length(avg_arr) - 1;
stem(x, avg_arr, "-.^r")
stem(x, GT, "--og")
legend(["generated", "GT"])
title("generated vs GT")
ylim([-0.1, 0.3])
xlabel("number of event")
ylabel("probability")

