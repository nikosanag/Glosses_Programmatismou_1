import java.util.LinkedList;
import java.util.Queue;

public class build {
    public static Queue<Integer> stash = new LinkedList<>();

    public static TreeNode construct_tree() {
        int info;
        TreeNode helper;
        if (stash.isEmpty() != true)
            info = stash.remove();
        else
            info = 0;

        if (info != 0) {
            helper = new TreeNode(info);
            helper.left = construct_tree();
            helper.right = construct_tree();
        } 
        else {
            return null;
        }
        return helper;

    }

    public static void move(TreeNode transfer) {

        TreeNode helper;
        helper = transfer.left;
        transfer.left = transfer.right;
        transfer.right = helper;
    }

    public static void modify_tree(TreeNode root) {
        if (root == null);

        else {
           
            if (root.left == null && root.right == null) root.important = root.number;
            
            else if (root.left!=null && root.right!=null){
                modify_tree(root.left);
                modify_tree(root.right);

                if (root.left.important > root.right.important) {
                  move(root); 
                    

                }
                //if(root.number<root.left.important) root.important = root.number; 
                //else root.important = root.left.important;
                root.important = root.left.important;
            }


            else if (root.right != null) {
                modify_tree(root.right);
                if (root.number > root.right.important) {
                    move(root);
                    

                    root.important = root.left.important;
                } 
                else{
                    root.important = root.number;
                }
            }

            else if (root.left != null) {
                modify_tree(root.left);
                if (root.number < root.left.important) {
                    move(root);
                      

                    root.important = root.number;
                } 
                else{
                    root.important = root.left.important;
                }
            }

           

        }

    }

    public static void preorder(TreeNode root) {
        System.out.print(root.number + " ");
        if (root.left != null)
            preorder(root.left);
        else
            System.out.print("0" + " ");
        if (root.right != null)
            preorder(root.right);
        else
            System.out.print("0" + " ");

    }

    public static void inorder(TreeNode root) {
        
            if (root != null){
            if (root.left != null) {inorder(root.left);}
            
            System.out.print(root.number + " ");
            
            if (root.right != null) {inorder(root.right);}
            }
        

    }

}
