clear
clc
% raise는 빠르고 fall은 느림
k = 4;
p = 0.2;
tot = 1000000;
cnt_arr = zeros(1, 200);
avg_arr = zeros(1, 200);
CDF_arr = zeros(1, 200);
GT = zeros(1, 200);

for i = 1:tot
    cnt = 0;
    idx = 0;
    while(1)
        if rand(1) < p
            cnt = cnt + 1;
        else
        end
        idx = idx + 1;
        if cnt == k
            break;
        else
        end
    end
    cnt_arr(idx) = cnt_arr(idx) + 1;
    
end

for i = 1:length(cnt_arr)
    probability = cnt_arr(i) / tot;
    avg_arr(i) = probability;
    if (i==1)
        CDF_arr(i) = probability;
    else
        CDF_arr(i) = CDF_arr(i-1) + probability;
    end
end

for i = 1:length(GT)
    if i < k
        continue;
    else
        res = comb(i - 1, k - 1)*(p^k)*((1-p)^(i-k));
        GT(i) = res;
        if res <= 1e-10 % 너무 작으면 오류가 남 그래서 미리 끊어준다.
            break; 
        end
    end
end

figure(1)
stem(avg_arr, "r")
title("PMF, Pascal")
ylim([-0.02, 0.1])
xlabel("number of event")
ylabel("probability")

figure(2)
stairs(CDF_arr)
title("CDF, Pascal")
ylim([-0.2, 1.2])

figure(3)
hold on
stem(avg_arr, "-.^r")
stem(GT, "--og")
legend(["generated", "GT"]) % legend
title("generated vs GT") % title 선언
xlim([-10, 100]) % ~100이내로 제한
ylim([-0.02, 0.1]) % PMF와 마찬가지로 ~0.5로 제한
xlabel("number of event") % x축 = event가 일어난 횟수
ylabel("probability") % y축 = 확률
