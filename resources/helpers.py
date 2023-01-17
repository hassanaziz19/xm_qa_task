import statistics


def st_dev(lst):
    """

    :param lst: List of data
    :return: standard deviation value
    """
    return statistics.stdev(lst)


def mean(lst):
    """

    :param lst: List of data
    :return: mean value
    """
    return sum(lst) / len(lst)
