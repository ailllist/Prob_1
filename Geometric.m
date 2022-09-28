p = 0.2;
n = 1000000;
cnt_arr = zeros(1, 100);
avg_arr = zeros(1, 100);
CDF_arr = zeros(1, 100);
GT = zeros(1, 100);

for i = 1:n
    cnt = 1;
    while (1)
        if rand(1) < 0.2
            break;
        else
        end
        cnt = cnt + 1;
    end
    cnt_arr(cnt) = cnt_arr(cnt) + 1;
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
    GT(i) = (1-p)^(i-1)*p;
end

figure(1)
stem(avg_arr, "r")
title("PMF, Geometric")
ylim([-0.1, 0.3])

figure(2)
stairs(CDF_arr)
title("CDF, Geometric")
ylim([-0.2, 1.2])

figure(3)
hold on
stem(avg_arr, "-.^r")
stem(GT, "--og")
legend(["generated", "GT"])
title("generated vs GT")

