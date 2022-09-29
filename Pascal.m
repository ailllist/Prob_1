k = 6;
p = 0.2;
tot = 10000000;
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
        GT(i) = comb(i - 1, k - 1)*(p^k)*((1-p)^(i-k));
    end
end

figure(1)
stem(avg_arr, "r")
title("PMF, Pascal")
ylim([-0.1, 0.3])

figure(2)
stairs(CDF_arr)
title("CDF, Pascal")
ylim([-0.2, 1.2])