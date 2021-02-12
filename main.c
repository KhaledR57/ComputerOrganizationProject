#include <stdio.h>

typedef struct {
    int priority;
    char name;
} Request;

Request list1[20];
Request list2[20];
Request list3[20];
Request list4[20];
Request all[80];

int get_size(Request list[]) {
    int size = 0;
    for (int i = 0; i < 20; ++i) {
        if (list[i].priority != 0)
            size++;
    }
    return size;
}

void add_request(Request request) {

    if (get_size(list1) < 20) {
        int i = 0;
        while (list1[i].priority != 0) {
            i++;
        }
        list1[i] = request;
    } else if (get_size(list2) < 20) {
        int i = 0;
        while (list2[i].priority != 0) {
            i++;
        }
        list2[i] = request;
    } else if (get_size(list3) < 20) {
        int i = 0;
        while (list3[i].priority != 0) {
            i++;
        }
        list3[i] = request;
    } else if (get_size(list4) < 20) {
        int i = 0;
        while (list4[i].priority != 0) {
            i++;
        }
        list4[i] = request;
    }

}

void process_request() {
    int nextPriority = 1;
    int found = 0;
    while (!found && nextPriority < 5) {
        found = 0;
        for (int i = 0; i < 20; ++i) {
            if (list1[i].priority == nextPriority) {
                printf("Request: %c , Priority: %d\n", list1[i].name, list1[i].priority);
                list1[i].priority = 0;
                found = 1;
                break;
            }
        }
        for (int i = 0; i < 20; ++i) {
            if (list2[i].priority == nextPriority) {
                printf("Request: %c , Priority: %d\n", list2[i].name, list2[i].priority);
                list2[i].priority = 0;
                found = 1;
                break;
            }
        }
        for (int i = 0; i < 20; ++i) {
            if (list3[i].priority == nextPriority) {
                printf("Request: %c , Priority: %d\n", list3[i].name, list3[i].priority);
                list3[i].priority = 0;
                found = 1;
                break;
            }
        }
        for (int i = 0; i < 20; ++i) {
            if (list4[i].priority == nextPriority) {
                printf("Request: %c , Priority: %d\n", list4[i].name, list4[i].priority);
                list4[i].priority = 0;
                found = 1;
                break;
            }
        }
        if (!found)
            nextPriority++;
    }
    if (!found)
        printf("\n");
}

void empty_lists() {
    for (int i = 0; i < 20; ++i) {
        list1[i].priority = 0;
        list2[i].priority = 0;
        list3[i].priority = 0;
        list4[i].priority = 0;
    }
}

void process_all_requests() {

    while (get_size(list1) + get_size(list2) + get_size(list3) + get_size(list4)) {
        process_request();
    }

    empty_lists();
}

void put_all() {
    int j = 0;
    for (int i = 0; i < 20; ++i) {
        if (list1[i].priority != 0) {
            all[j++] = list1[i];
        }
    }
    for (int i = 0; i < 20; ++i) {
        if (list2[i].priority != 0) {
            all[j++] = list2[i];
        }
    }
    for (int i = 0; i < 20; ++i) {
        if (list3[i].priority != 0) {
            all[j++] = list3[i];
        }
    }
    for (int i = 0; i < 20; ++i) {
        if (list4[i].priority != 0) {
            all[j++] = list4[i];
        }
    }

}


int partition(int low, int high) {
    char pivot = all[high].name;
    int i = (low - 1);

    for (int j = low; j <= high - 1; j++) {
        if (all[j].name < pivot) {
            i++;
            Request temp = all[i];
            all[i] = all[j];
            all[j] = temp;
        }
    }

    Request temp = all[i + 1];
    all[i + 1] = all[high];
    all[high] = temp;

    return (i + 1);
}


void quick_sort(int low, int high) {
    if (low < high) {
        int pi = partition(low, high);

        quick_sort(low, pi - 1);
        quick_sort(pi + 1, high);
    }
}

void join_lists(int first, int second) {

    Request *l1 = NULL;
    Request *l2 = NULL;

    if (first == 1)
        l1 = list1;
    else if (first == 2)
        l1 = list2;
    else if (first == 3)
        l1 = list3;
    else if (first == 4)
        l1 = list4;

    if (second == 1)
        l2 = list1;
    else if (second == 2)
        l2 = list2;
    else if (second == 3)
        l2 = list3;
    else if (second == 4)
        l2 = list4;

    if (get_size(l1) + get_size(l2) <= 20) {

        for (int i = 0, j = 0; i < 20 && j < 20;) {

            while (l1[i].priority != 0) {
                i++;
            }
            while (l2[j].priority == 0) {
                j++;
            }
            l1[i].priority = l2[j].priority;
            l1[i].name = l2[j].name;
            l2[j].priority = 0;
        }
    } else
        printf("Size Limit Exceeded");
}

void binary_search(int l, int r, char name) {
    put_all();
    quick_sort(0, (get_size(list1) + get_size(list2) + get_size(list3) + get_size(list4)) - 1);

    if (r >= l) {
        int mid = l + (r - l) / 2;

        if (all[mid].name == name)
            printf("Request: %c , Priority: %d\n", all[mid].name, all[mid].priority);

        if (all[mid].name > name)
            return binary_search(l, mid - 1, name);

        return binary_search(mid + 1, r, name);
    }
}

void update_priority(char name, int priority) {
    for (int i = 0; i < 20; ++i) {
        if (list1[i].name == name)
            list1[i].priority = priority;
        if (list2[i].name == name)
            list2[i].priority = priority;
        if (list3[i].name == name)
            list3[i].priority = priority;
        if (list4[i].name == name)
            list4[i].priority = priority;
    }
}

int main() {
    empty_lists();
    while (1) {

        int choice;

        printf("Please Enter The Number Of The Operation You Want\n");
        printf("1 - Add Request.\n");
        printf("2 - Process a Request.\n");
        printf("3 - Join Lists.\n");
        printf("4 - Empty all lists.\n");
        printf("5 - Update Request Priority.\n");
        printf("6 - Process all requests in all lists.\n");
        printf("7 - Search on specific Request use Binary Search on lists.\n");

        scanf("%d", &choice);

        if (choice == 1) {

            Request request;
            printf("Enter Request Name: ");
            fflush(stdin);
            request.name = getchar();
            fflush(stdin);
            printf("Enter Request Priority: ");
            scanf("%d", &request.priority);

            add_request(request);

        } else if (choice == 2) {

            process_request();

        } else if (choice == 3) {
            int num;
            printf("Enter Number Of Lists You Want To Join: ");
            scanf("%d", &num);
            int l1;
            int l2;
            printf("Enter The Number Of The First List: ");
            scanf("%d", &l1);
            while (num--) {
                printf("Enter The Number Of The Another List: ");
                scanf("%d", &l2);
                join_lists(l1, l2);
            }
        } else if (choice == 4) {

            empty_lists();
            printf("All Lists Are Empty Now!\n");

        } else if (choice == 5) {

            char name;
            printf("Enter Request Name: ");
            fflush(stdin);
            name = getchar();
            fflush(stdin);
            printf("Enter The New Request Priority: ");
            int priority;
            scanf("%d", &priority);
            update_priority(name, priority);

        } else if (choice == 6) {

            process_all_requests();
            printf("Done!\n");

        } else if (choice == 7) {

            char name;
            printf("Enter Request Name You Want To Search For: ");
            fflush(stdin);
            name = getchar();
            fflush(stdin);
            binary_search(0, (get_size(list1) + get_size(list2) + get_size(list3) + get_size(list4)), name);
            printf("Done!\n");

        } else
            break;
    }

    return 0;
}