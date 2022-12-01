import numpy as np
import itertools
import time

def get_all_pairs(coords):
    pairs = []

    for index, start in enumerate(coords[:-1]):
        for end in coords[index+1:]:
            pairs.append([start,end])
    return pairs

def create_cost_matrix_dictionary(coords):
    cost_dict = {}
    for spot in range(len(coords)):
        cost_dict[coords[spot]] = spot
    return cost_dict

def exhaustive_search(coords):

    num_coords = len(coords)

    # Get all pairs of coordinates, assuming inverse cost is equal
    pairs = get_all_pairs(coords)

    # Create cost dictionary to allow for coords to be used as indicies
    cost_dict = create_cost_matrix_dictionary(coords)
    print(cost_dict)

    # Instantiate cost matrix as nxn matrix of all zeroes
    cost_matrix = np.zeros((num_coords,num_coords))
    print(cost_matrix)

    # Set up rng
    rand_gen = np.random.default_rng(int(time.time()))

    # Calculate cost for each pair of coordinates (currently random)
    for pair in pairs:
        cost_matrix[cost_dict[pair[0]]][cost_dict[pair[1]]] = rand_gen.random()*10 + 1
        print(pair, cost_matrix[cost_dict[pair[0]]][cost_dict[pair[1]]])

    # Mirror costs across diagonal
    cost_matrix = cost_matrix + cost_matrix.T # - np.diag(np.diag(cost_matrix))
    print(cost_matrix)

    cost_min = np.inf
    optimal_route = []
    curr_sum = 0

    # Get all permutations of coordinates
    routes = list(itertools.permutations(coords))
    print(routes)

    # Brute-force optimal route
    for route in routes:
        for spot in range(num_coords-1):
            curr_sum += cost_matrix[cost_dict[route[spot]]][cost_dict[route[spot+1]]]
        #print(route, curr_sum)
        if curr_sum < cost_min:
            optimal_route = route
            cost_min = curr_sum
        curr_sum = 0

    return optimal_route, cost_min

def test_stuff():
    pass

#test_stuff()


coords = ["A","B","C","D","E"]
print(exhaustive_search(coords))
