import { Identity } from "@semaphore-protocol/core"
import { useRouter } from "next/navigation"
import { useEffect, useState } from "react"

export default function useSemaphoreIdentity() {
    const router = useRouter()
    const [_identity, setIdentity] = useState<Identity>()

    useEffect(() => {
        // ブラウザのローカルストレージからIdentityを取得
        const privateKey = localStorage.getItem("identity")

        if (!privateKey) {
            router.push("/")
            return
        }
        // IdentityをStateにセット
        setIdentity(new Identity(privateKey))
    }, [router])

    return {
        _identity
    }
}
