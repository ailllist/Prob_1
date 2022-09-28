function [res] = comb(n, k)
    res = factorial(n) / (factorial(k)*factorial(n-k));
end