function norm_taylor_diag(mat, ref, varargin)

    % number of time series
    nts = length(ref);
    
    % ------------------ %
    % compute statistics %
    % ------------------ %
    
    % stat is a matrix gathering all the statistics about time series
    % row #1: mean
    % row #2: bias
    % row #3: root mean square error
    % row #4: centered root mean square error
    % row #5: standard deviation
    % row #6: correlation coefficien
    stat = zeros(6, nts);

    % reference time series IDs
    ref_id = [];
    for i = 1:nts
        if ref(i) == i
            ref_id = [ref_id i];
        end
    end
    
    % indices of "not NaN" data in each time series
    ind = cell(1, nts);
    for i = 1:nts
        ind{i} = find(~isnan(mat(:, i)));
    end
    
    % for each time series
    for i = 1:nts
        
        % time series
        X = mat(ind{ref(i)}, i);
        
        % reference time series
        Xref = mat(ind{ref(i)}, ref(i));
        
        % number of data
        N = length(X);
        
        % mean
        S = mean(X);
        
        % mean of the reference time series
        Sref = mean(Xref);
        
        % bias
        bias = S - Sref;
        
        % root mean square error
        RMSE = sqrt(sum((X - Xref) .^ 2) / N);
        
        % centered root mean square error
        CRMSE = sqrt(sum(((X - S) - (Xref - Sref)) .^ 2) / N);
        
        % standard deviation
        sigma = sqrt(sum((X - S) .^ 2) / N);
        
        % standard deviation of the reference
        sigmaref = sqrt(sum((Xref - Sref) .^ 2) / N);

        % correlation coefficient
        R = sum((X - S) .* (Xref - Sref)) / (N * sigma * sigmaref);
        
        % statistic matric
        stat(1, i) = S;
        stat(2, i) = bias;
        stat(3, i) = RMSE;
        stat(4, i) = CRMSE;
        stat(5, i) = sigma;
        stat(6, i) = R;
        
    end
    
    
    % ------------- %
    % create figure %
    % ------------- %
    
    figure
    hold on
    axis equal
    ax = gca;
    ax.LineWidth = 1;
    ax.FontSize = 14;
    
    
    % ------------------ %
    % standard deviation %
    % ------------------ %
    
    % normalize standard deviation
    sigma = stat(5, :) ./ stat(5, ref);
    
    % maximum standard deviation
    sigmamax = max(sigma);
    
    % standard deviation limit on diagram
    sigmalim = max(1.25, ceil(sigmamax * 4) / 4);
    ax.XLim = ([0 sigmalim]);
    ax.YLim = ([0 sigmalim]);
    
    % draw circles
    for i = 0.25:0.25:sigmalim
        theta = 0:90;
        x = i * cosd(theta);
        y = i * sind(theta);
        if i == 1
            h = plot(x, y);
            h.Color = 'k';
            h.LineWidth = 2;
            h.LineStyle = '-';
        elseif i == sigmalim
            h = plot(x, y);
            h.Color = ax.ColorOrder(3, :);
            h.LineWidth = 1;
            h.LineStyle = '-';
        else
            h = plot(x, y);
            h.Color = 'k';
            h.LineWidth = 1;
            h.LineStyle = '--';
        end
    end
    
    % axis
    ax.YTick = [0.25:0.25:sigmalim - 0.25];
    ax.YLabel.String = 'standard deviation';
    
    
    % ------------------------------- %
    % centered root mean square error %
    % ------------------------------- %
    
    % draw circles
    for i = 0.25:0.25:1
        
        % full circles
        theta = 0:180;
        x = i * cosd(theta) + 1;
        y = i * sind(theta);
        
        % remove what is outside the diagram
        ind = find(x <= (1 + sigmalim ^ 2 - i ^ 2) * 0.5);
        x = x(ind);
        y = y(ind);
        
        % plot
        h = plot(x, y);
        h.Color = ax.ColorOrder(1, :);
        h.LineWidth = 1;
        h.LineStyle = '--';
    end
    
    % axis
    ax.XTick = [0:0.25:0.75];
    ax.XTickLabel = [1:-0.25:0.25];
    ax.XLabel.String = 'centered root mean square error';
    ax.XColor = ax.ColorOrder(1, :);
    
    
    % ----------------------- %
    % correlation coefficient %
    % ----------------------- %
    
    % tick values
    tick = [0.1:0.1:0.9 0.95 0.99];
    
    for i = 1:length(tick)
        
        % draw lines
        x = [0 sigmalim * tick(i)];
        y = [0 sigmalim * sin(acos(tick(i)))];
        h = plot(x, y);
        h.Color = ax.ColorOrder(3, :);
        h.LineWidth = 1;
        h.LineStyle = ':';
        
        % write ticks
        h = text(x(2), y(2), num2str(tick(i)));
        h.Color = ax.ColorOrder(3, :);
        h.FontSize = 14;
        h.VerticalAlignment = 'bottom';
        h.HorizontalAlignment = 'center';
        h.Rotation = acos(tick(i)) * 180 / pi - 90;
    end
    
    % title
    h = text((sigmalim + 0.08) * cosd(45), (sigmalim + 0.08) * sind(45), ...
             'correlation coefficient');
    h.Color = ax.ColorOrder(3, :);
    h.FontSize = 14;
    h.VerticalAlignment = 'bottom';
    h.HorizontalAlignment = 'center';
    h.Rotation = -45;
    
    
    % --------- %
    % plot data %
    % --------- %
    
    % reference point
    h = plot(1, 0);
    h.Color = 'k';
    h.Marker = '.';
    h.MarkerSize = 30;
    
    % other points
    r = stat(5, :) ./ stat(5, ref);
    theta = acos(min(1, stat(6, :)));
    x = r .* cos(theta);
    y = r .* sin(theta);
    
    for i = 1:nts
        if sum(i == ref) == 0
            h = plot(x(i), y(i));
            h.Color = ax.ColorOrder(2, :);
            h.Marker = '.';
            h.MarkerSize = 20;
        end
    end
    
    