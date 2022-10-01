function [res] = comb(n, k) % combination 구현 함수
    res = factorial(n) / (factorial(k)*factorial(n-k));
end