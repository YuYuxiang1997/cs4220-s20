obj = p1setup();
x_l = -6:6/100:0;
[~,iters] = size(x_l);
x = zeros(1,iters);
count = 1;
for z = x_l
    x(count) = 1*(10^z);
    count = count + 1;
end
y = zeros(size(x));
Z = sign(rand(h, w, 10)-0.5);
count = 1;
for z = x
    [y(count),~] = p1gcv(obj,z,Z);
    count = count + 1;
end
loglog(x, y);
[asdasd,~] = p1gcv(obj,0.0147,Z);
hold on
 plot(0.0147,asdasd,'r*')  % marking the 10th data point of x and y