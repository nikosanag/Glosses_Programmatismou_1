import java.io.FileNotFoundException;

public class Arrange {

    public static int total_nodes;

    public static void main(String[] args) throws FileNotFoundException {

        extract_from_txtfile.extraction("tree1.txt");
        TreeNode root = build.construct_tree();

        build.modify_tree(root);// modifies the tree
        build.inorder(root);// prints nodes inorder

        // build.preorder(root); System.out.println();

    }
}
