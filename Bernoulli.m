clear
clc

p = 0.3;

Y = zeros(1, 100000);
GT = zeros(1, 2);

cnt = 1;
while (cnt < length(Y))
    x = rand(1);
    if x <= p
        Y(cnt) = 1;
    else
        Y(cnt) = 0;
    end
    cnt = cnt + 1;
end

avg = sum(Y)/length(Y);

oat = [1-avg avg];
obt = [0 1];
CDF_arr = [0, avg, 1, 1];

figure(1)
stem([0 1], oat);
xlim([-0.5 1.5])
ylim([-0.5 1.5])
title("PMF, Bernoulli")
xlabel("number of event")
ylabel("probability")

figure(2)
hold on
stairs([-1 0 1 2], CDF_arr)
ylim([-1 3])
title("CDF, Bernoulli")

