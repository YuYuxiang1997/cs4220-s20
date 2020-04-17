function [lambda] = p1gcvopt(obj, lmin, lmax, Z)

    myfun = @p1gcv;
    newfun = @(x) myfun(obj, x, Z);
    function [dG] = helper(x)
       [~,dG] = newfun(x);
    end
    
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
        y(count) = helper(z);

        count = count + 1;
    end
    semilogx(x, y);
    lambda = fzero(@helper,1e-2);
end