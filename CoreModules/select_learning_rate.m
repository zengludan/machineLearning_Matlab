function [lr_best, min_cost] = select_learning_rate(net, opts)
temp_net = net;
net = [];
opts.parameters.cost = zeros(size(opts.parameters.lrs));

for l = 1: length(opts.parameters.lrs)
    net = temp_net;
    opts.parameters.lr = opts.parameters.lrs(l);
    opts.reset_mom=1;
    net.iterations=0;
    
    if (isfield(opts.parameters, 'selected_lr') && length(opts.parameters.selected_lr) > 0 && opts.parameters.lr > opts.parameters.selected_lr(1))
        cost = 100;
        opts.parameters.cost(l) = cost;
        continue;
    else
        for mini_b = 1: min(opts.n_batch, opts.parameters.search_iterations)
            idx = opts.order(1 + (mini_b - 1) * opts.parameters.batch_size:mini_b * opts.parameters.batch_size);
            if length(size(opts.train)) == 2 % train mlp
                res(1).x = opts.train(:, idx);
            else % train cnn
                res(1).x = opts.train(:, :, :, idx);
            end
            res(1).class = opts.train_labels(idx);
            
            % forward
            [net, res, opts] = net_ff(net, res, opts);
            % backward
            opts.dzdy = single(1.0);
            [net, res, opts] = net_bp(net,res,opts);
            cost = gather(mean(res(end).x(:)));
            
            if cost > 100
                cost = 100;
                break;
            end
            [net, res, opts] = opts.parameters.learning_method(net, res, opts);
        end
    end
    
    opts.parameters.cost(l) = cost;
    disp(['learning rate, ', num2str(opts.parameters.lrs(l)), ' cost, ' num2str(cost)]);
end
[min_cost, min_idx] = min(opts.parameters.cost);
lr_best = opts.parameters.lrs(min_idx);
end