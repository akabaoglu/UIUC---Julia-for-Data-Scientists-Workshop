using Random
Random.seed!(123)

# 1.1
v1 = rand(100)

function vec_diff(x)
    return maximum(x) - minimum(x)
end

vec_diff(v1)

# 1.2
v_series = [rand(20) for _ in 1:100]

sum(v_series[79])

# 1.3
vec_diff.(v_series)

# 1.4
map(vec_diff, v_series)

# 1.5
map(x -> maximum(x) - minimum(x), v_series)


# 2.1
10^11 > 11^10

# 2.2
rand_mat = round.(rand(100, 3), digits = 2)

(rand_mat[:, 1]) > (rand_mat[:, 2])

# 2.3
map(x -> x > .47, rand_mat[:, 3])

# 2.4
map((x, y) -> x > y, rand_mat[:, 1], rand_mat[:, 3])

# 2.5
sum(map(x -> x == .52, rand_mat[:, 1]))


# 3.1
l1 = -100:1:100

l1 = filter(iseven, l1)

# 3.2
replace!(x -> abs(x) > 10 ? x % 3 : x^2, l1)

# 3.3
filter!(x -> x != 0, l1)

# 3.4
sort!(l1, rev = true)

# 3.5 
intersect(l1, -100:1:100)