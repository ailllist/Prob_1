n = 100000;
p = 0.0001;
tot = 1000;

counting_arr = zeros(1, n);
avg_arr = zeros(1, n);
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

figure(1)
stem(avg_arr, "r")
title("PMF, Binomial")
xlim([-10, 100])
ylim([-0.1, 0.2])