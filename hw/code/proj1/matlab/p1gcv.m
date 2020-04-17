function [G, dG] = p1gcv(obj, lambda, z)

    %calculate G
    [h, w, ~] = size(obj.imblur);
    N = 3 * h * w;
    p_lambda = p1resid(obj, lambda);
    [~, ~, c] = size(z);
    m = c;
    
    sum = 0;
    for i = 1:c
        Zi = z(:,:,i);
        Ri = Zi - p1applyH(obj, p1tikhonovd(obj, lambda, Zi));
        item = Zi(:)'*Ri(:);
        sum = sum + item;
    end
    denominatorG = sum;
    denominatorG_squared = denominatorG * denominatorG;
    G_num = N * p_lambda * p_lambda * m * m;

    G = G_num / denominatorG_squared;
    
    p1resid_as_matrix = p1applyH(obj, p1tikhonovd(obj, lambda)) - double(obj.imblur);
    first_inner_prod = p1tikhonovd(obj, lambda, p1resid_as_matrix);
    second_inner_prod = -2 * lambda * p1tikhonovd(obj, lambda);
    d_p_lambda_s = 0;
    for i = 1:3
        f = first_inner_prod(:,:,i);
        s = second_inner_prod(:,:,i);
        d_p_lambda_s = d_p_lambda_s + dot(f(:), s(:));
    end
    d_p_lambda_s = 2 * d_p_lambda_s;
    firstTermGprime = N * m * m * d_p_lambda_s / denominatorG_squared;
    
    sum_numer = 0;
    for i = 1:c
        item = p1tikhonovd(obj, lambda, z(:,:,i));
        sum_numer = sum_numer + item(:)' * item(:);
    end
    secondTermGprime = 2 * N * p_lambda * p_lambda * m * m * 2 * lambda * sum_numer / (denominatorG^3);
    dG = firstTermGprime - secondTermGprime;
    
end