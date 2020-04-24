https://stackoverflow.com/questions/409784/whats-the-simplest-way-to-print-a-java-array

- Simple Array:
    ```
    String[] array = new String[] {"John", "Mary", "Bob"};
    System.out.println(Arrays.toString(array));
    ```

    Output:

    [John, Mary, Bob]


- Nested Array:

    ```
    String[][] deepArray = new String[][] {{"John", "Mary"}, {"Alice", "Bob"}};
    System.out.println(Arrays.toString(deepArray));
    //output: [[Ljava.lang.String;@106d69c, [Ljava.lang.String;@52e922]
    System.out.println(Arrays.deepToString(deepArray));
    ```
    Output:

    [[John, Mary], [Alice, Bob]]