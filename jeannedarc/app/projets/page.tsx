import { usePathname } from "next/navigation";


export default function Page() {
	const pathname = usePathname();
  return (
    <>
      <main >
       <h1>Page: {pathname}</h1>
      </main>
    </>
  );
}
