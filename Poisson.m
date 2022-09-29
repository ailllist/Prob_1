alp = 2;
n = 100000;
p = alp/n;
tot = 10000;

counting_arr = zeros(1, n);
avg_arr = zeros(1, n);
CDF_arr = zeros(1, n);
GT = zeros(1, n);

zero_cnt = 0;

for i = 1:tot
    count_sel = 0;
    for j = 1:n
        if rand(1) < p
            count_sel = count_sel + 1;
        else
        end
    end
    if count_sel ~= 0    
        counting_arr(count_sel) = counting_arr(count_sel) + 1;
    else
        zero_cnt = zero_cnt + 1;
    end
    i
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
    GT(i) = (alp^i)*((exp(-alp))/factorial(i));
end

figure(1)
stem(avg_arr, "r")
title("PMF, Poisson")
xlim([-10, 100])
ylim([-0.1, 0.2])

figure(2)
stairs(CDF_arr)
title("CDF, Poisson")