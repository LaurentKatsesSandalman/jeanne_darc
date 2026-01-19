'use client'

import { useClerk } from "@clerk/nextjs";
import { usePathname, useRouter } from "next/navigation";
import styles from "./LogoutButton.module.css"
import { LogoutIcon } from "@/components/Icons/Icons";

export function LogoutButton() {
  const { signOut } = useClerk();
  const router = useRouter();
  const pathname = usePathname();
  
  const handleLogout = async () => {
    await signOut({ redirectUrl: pathname });
    router.refresh(); // Force le rafraîchissement de la page actuelle
  };
  
  return (
    <button 
      onClick={handleLogout}
      className={styles.logoutBtn}
    >
      <LogoutIcon className={styles.logoutIcon}/>
    </button>
  );
}