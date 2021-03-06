function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.
    
    alpha = 100; % sampling rate/image
    filterBank  = createFilterBank();
    featureLength = 3*size(filterBank,1);
    disp(featureLength)
    for path = 1:size(imPaths,1)
        img = imread(imPaths{path});
        filterResponses = extractFilterResponses(img,filterBank);
        rowVal = size(img,1);
        colVal = size(img,2);
        row = randperm(rowVal,alpha);
        col = randperm(colVal,alpha);
        for i = 1:alpha
            temp = filterResponses(row(i),col(i),:);
            temp = reshape(temp,[1,featureLength]);
            if exist('features','var')
                features = cat(1,features,temp);
            else
                features = temp;
            end
        end
        
        
    end
    % TODO Implement your code here
    k = 150;
    [idx,dictionary] = kmeans(features,k,'EmptyAction','drop');
    dictionary = dictionary';

end
