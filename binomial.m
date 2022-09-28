n = 100;
p = 0.2;
tot = 1000000;

counting_arr = zeros(1, n);
avg_arr = zeros(1, n);
GT = zeros(1, n);
CDF_arr = zeros(1, n);

for i = 1:tot
    count_sel = 0;
    for j = 1:n
        if rand(1) < p
            count_sel = count_sel + 1;
        else
        end
    end
    counting_arr(count_sel) = counting_arr(count_sel) + 1;
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
    GT(i) = comb(n, i)*(p^i)*((1-p)^(n-i));
end

err_arr = GT - avg_arr;

figure(1)
stem(avg_arr, "r")
title("PMF, Binomial")
xlim([-10, n + 10])
ylim([-0.1, 0.2])

figure(2)
stairs(CDF_arr)
title("CDF, Binomial")
ylim([-0.5, 1.5])

figure(3)
hold on
stem(avg_arr, "-.^r")
stem(GT, "--og")
legend(["generated", "GT"])
title("generated vs GT"), 