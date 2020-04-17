obj = p1setup();
x_l = -4:4/100:0;
[~,iters] = size(x_l);
x = zeros(1,iters);
count = 1;
for z = x_l
    x(count) = 1*(10^z);
    count = count + 1;
end
y = zeros(size(x));
count = 1;
for z = x
    y(count) = p1resid(obj, z);
    count = count + 1;
end
[h, w, ~] = size(obj.imblur);

y1 = sqrt(h*w/4);
y2 = zeros(size(x));
count = 1;
for z = x
    y2(count) = y1;
    count = count + 1;
end

count = 1;
y3 = zeros(size(x));
for z = x
    y3(count) = p1residAlter(obj, z);
    count = count + 1;
end
loglog(x, y, 'r', x, y2, '--', x, y3, 'b');