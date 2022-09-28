Y = zeros(1, 100000);

cnt = 1;
while (cnt < length(Y))
    x = rand(1);
    if x <= 0.7
        Y(cnt) = 1;
    else
        Y(cnt) = 0;
    end
    cnt = cnt + 1;
end

avg = sum(Y)/length(Y);

oat = [1-avg avg];
obt = [0 1];

figure(1)
bar(obt, oat, 0.1)
xlim([-0.5 1.5])
ylim([-0.5 1.5])
title("PMF, Bernoulli")

figure(2)
hold on
ylim([-1 2])
plot([-1 0], [0 0], "b")
plot([0 1], [1-avg 1-avg], "b")
plot([1 2], [1 1], "b")
title("CDF, Bernoulli")

