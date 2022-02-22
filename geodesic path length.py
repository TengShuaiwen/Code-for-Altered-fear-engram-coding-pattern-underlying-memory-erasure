
import numpy as np
import pandas as pd
# calculate the Geodesic path length between any two nodes(the Floyd algorithm ).
# input:  Intercellular adjacency matrix
# output: The Geodesic path length
# 2021.12 Xinrong Wang

INFINITY = 65535

def normalization(data):
    # df = pd.DataFrame(data)
    # df.replace(np.inf, 0)
    _range = np.max(data) - np.min(data)
    return (data - np.min(data)) / _range

file_path = 'K:/easure memory/adj/pl014_RINE_trace_Adj_matrix_new.xlsx'
D = pd.read_excel(file_path,header=None)
D = 1/D
# D = round(D*10)
D = np.array(D)

D = D[:,:]
# D[D==0] = 65535
row, col = np.diag_indices_from(D)
D[row, col] = 0
lengthD = len(D)
# p = list(range(lengthD))
# P = []
# for i in range(lengthD):
#     P.append(p)
# P = np.array(P)
N = lengthD
path = np.zeros((N,N))
for k in range(lengthD):
    for i in range(lengthD):
        for j in range(lengthD):
            # if(D[i,j]> str(D[i,k])+str(D[k,j])):
            if(D[i,j]> D[i,k]+D[k,j]):
                D[i,j] = D[i,k] + D[k,j]
                path[i][j] = path[i][k]

    print('result:')

# D = D.tolist()
remo = len(D[np.isinf(D)])
# D[D==inf] = 0
# D=normalization(D)
where_are_nan = np.isnan(D)
where_are_inf = np.isinf(D)
D[where_are_nan] = 0
D[where_are_inf] = 0
D = normalization(D)

print(D,'\n',path)

cc=np.sum(D)/(lengthD*lengthD-lengthD-remo)
print(cc)
dff = pd.DataFrame(D)
dff.to_excel('K:/easure memory/....xlsx')
